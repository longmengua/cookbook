package com.h2uclub.hi365;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.AtomicFile;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInOptionsExtension;
import com.google.android.gms.fitness.Fitness;
import com.google.android.gms.fitness.FitnessOptions;
import com.google.android.gms.fitness.data.DataPoint;
import com.google.android.gms.fitness.data.DataSet;
import com.google.android.gms.fitness.data.DataType;
import com.google.android.gms.fitness.data.Field;
import com.google.android.gms.fitness.data.HealthDataTypes;
import com.google.android.gms.fitness.request.DataReadRequest;
import com.google.android.gms.fitness.result.DataReadResponse;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.nhi.mhbsdk.MHB;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.model.FileHeader;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import us.zoom.sdk.InMeetingAudioController;
import us.zoom.sdk.InMeetingChatMessage;
import us.zoom.sdk.InMeetingEventHandler;
import us.zoom.sdk.InMeetingService;
import us.zoom.sdk.InMeetingServiceListener;
import us.zoom.sdk.JoinMeetingOptions;
import us.zoom.sdk.JoinMeetingParams;
import us.zoom.sdk.MeetingError;
import us.zoom.sdk.MeetingService;
import us.zoom.sdk.MeetingServiceListener;
import us.zoom.sdk.MeetingStatus;
import us.zoom.sdk.ZoomSDK;
import us.zoom.sdk.ZoomSDKAuthenticationListener;
import us.zoom.sdk.ZoomSDKInitializeListener;

import static com.h2uclub.hi365.common.StreamUtil.closeStream;
import static com.h2uclub.hi365.common.StreamUtil.copyStreams;

// ZOOM
//fitness

public class NHIAndroidActivity extends FlutterActivity
        implements Constants, ZoomSDKInitializeListener, MeetingServiceListener, InMeetingServiceListener, ZoomSDKAuthenticationListener {
    private static final String TAG = NHIAndroidActivity.class.getSimpleName();
    private static final String MHB_CHANNEL = "com.h2uclub.hi365/mhb";
    private MHB mhbInstance;
    private static final String CHANNEL = "com.h2uclub.hi365/health";// fitkit
    private static final String ZOOM_CHANNEL = "com.h2uclub.hi365/join_meeting";
    private static final String ALGORITHM_NAME = "PBKDF2WithHmacSHA1";
    private ZoomSDK zoomSDK = ZoomSDK.getInstance();
    private static MethodChannel.Result zoomChannelResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        initMhbInstance(this);
        initZoomService(savedInstanceState);
        getMHBoperation();
        getHealthInfo();
    }

    public void initZoomService(Bundle savedInstanceState) {
        if (savedInstanceState == null) {
            zoomSDK.initialize(this, APP_KEY, APP_SECRET, "zoom.us", this);
        }
        new MethodChannel(getFlutterView(), ZOOM_CHANNEL).setMethodCallHandler((call, result) -> {
            // Note: this method is invoked on the main thread.
            if (call.method.equals("joinMeeting")) {
                onClickBtnJoinMeeting(call.arguments.toString());
            }
        });
    }

    public void onClickBtnJoinMeeting(String meetingNo) {
        // Get Zoom SDK instance.
        ZoomSDK zoomSDK = ZoomSDK.getInstance();
        // Check if the zoom SDK is initialized
        if (!zoomSDK.isInitialized()) {
            Toast.makeText(this, "ZoomSDK has not been initialized successfully", Toast.LENGTH_LONG).show();
            return;
        }

        // Get meeting service from zoom SDK instance.
        MeetingService meetingService = zoomSDK.getMeetingService();

        // Configure meeting options.
        JoinMeetingOptions opts = new JoinMeetingOptions();
        // Some available options
        // opts.no_driving_mode = true;
        // opts.no_invite = true;
        // opts.no_meeting_end_message = true;
        // opts.no_titlebar = true;
        // opts.no_bottom_toolbar = true;
        // opts.no_dial_in_via_phone = true;
        // opts.no_dial_out_to_phone = true;
        // opts.no_disconnect_audio = true;
        // opts.no_share = true;
        // opts.invite_options = InviteOptions.INVITE_VIA_EMAIL +
        // InviteOptions.INVITE_VIA_SMS;
        // opts.no_audio = true;
        // opts.no_video = true;
        // opts.meeting_views_options = MeetingViewsOptions.NO_BUTTON_SHARE;
        // opts.no_meeting_error_message = true;
        // opts.participant_id = "participant id";

        // Setup join meeting parameters
        JoinMeetingParams params = new JoinMeetingParams();
        params.displayName = "Superman";
        params.meetingNo = meetingNo;
        // meeting service to join meeting
        int ret = meetingService.joinMeetingWithParams(this, params, opts);
        if (ret == 0) {
            InMeetingService mInMeetingService = zoomSDK.getInMeetingService();
            mInMeetingService.addListener(this);
        }
    }

    public void initMhbInstance(Context context) {
        try {
            mhbInstance = MHB.configure(context, BuildConfig.MHB_API_KEY);
            Log.d(TAG, "=== MHB instance init: ");
        } catch (Exception e) {
            Log.e(TAG, "=== MHB configuration failed: " + e.getMessage(), e);
        }
    }

    public final MHB getMhbInstance() {
        return mhbInstance;
    }

    public void getMHBoperation() {
        new MethodChannel(getFlutterView(), MHB_CHANNEL).setMethodCallHandler(new MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, Result result) {
                Log.d(TAG, "===  onMethodCall : " + call.method);
                if (call.method.equals("getMHBoperation")) {
                    openMHBScreen(result);
                } else if (call.method.equals("checkMHBFiles")) {
                    checkMHBFiles(result);
                } else {
                    result.notImplemented();
                }
            }
        });
    }

    public void openMHBScreen(Result result) {
        new Handler(Looper.getMainLooper()).post(() -> {
            getMhbInstance().startProc(new MHB.StartProcCallback() {
                @Override
                public void onStarProcSuccess() {
                    Log.d(TAG, "openMHBScreen successfully !");
                }

                @Override
                public void onStartProcFailure(String error_code) {
                    Log.d(TAG, "openMHBScreen Failure !. Error Code:" + error_code);
                    result.error(error_code, "openMHBScreen Failure !", null);
                    // Map mhbStatusMap = buildMHBStatusCode(error_code);
                    // MethodChannel channel = new MethodChannel(getFlutterView(), MHB_CHANNEL);
                    // channel.invokeMethod("showMHBStatus", mhbStatusMap);
                }
            });
        });
    }

    public int countMHBFiles() {
        int zipFileCount = getMHBFiles().size();
        Log.d(TAG, "local file size: " + zipFileCount);
        return zipFileCount;
    }

    private Map<String, Object> getReturnMessageObj(String methodName, String statusCode, String details,
            String fileName) {
        Map<String, Object> returnDataMap = new HashMap<>();
        returnDataMap.put("methodName", methodName);
        returnDataMap.put("code", statusCode);
        returnDataMap.put("content", details);
        if (null != fileName) {
            returnDataMap.put("fileName", fileName);
        }
        return returnDataMap;
    }

    public void checkMHBFiles(Result result) {
        Log.d(TAG, "checkMHBFiles !");
        if (countMHBFiles() > 0) {
            new Handler(Looper.getMainLooper()).post(() -> {
                List<String> fileTickets = getMHBFiles();
                if (0 >= fileTickets.size()) {
                    Log.i(TAG, "empty zip file !");
                    result.success(getReturnMessageObj("checkMHBFiles", "空的產製檔案", null, null));
                }
                Log.i(TAG, "ready to unzip file !");
                openMhbFile(fileTickets.get(0), result);
            });
        }
    }

    private List<String> getMHBFiles() {
        Map<String, ?> entries = getSharedPreferences(this.getPackageName(), Activity.MODE_PRIVATE).getAll();
        List<String> fileTickets = new ArrayList<>();
        for (String key : entries.keySet()) {
            if (key.startsWith("File_Ticket_")) {
                fileTickets.add(key);
            }
        }
        return fileTickets;
    }

    private void writeToFile(InputStream input, File destFile) throws IOException {
        InputStream origStream = null;
        OutputStream destStream = null;
        try {
            origStream = new BufferedInputStream(input);
            destStream = new BufferedOutputStream(new FileOutputStream(destFile));
            copyStreams(origStream, destStream);
        } finally {
            closeStream(origStream);
            closeStream(destStream);
        }
    }

    private String readJsonFile(String file_path) {
        StringBuilder stb = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(file_path), "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                stb.append(line);
            }
            in.close();
        } catch (Exception e) {
            Log.e(TAG, "writeToFile error.", e);
        }

        return stb.toString();
    }

    private void deleteOldFiles(File... files) {
        for (File f : files) {
            f.deleteOnExit();
        }
    }

    /**
     * android native call flutter method through methodChannel call flutter
     * function to handle upload json
     */
    private void callFlutterUploadMHBJson(Map<String, Object> obj) {
        MethodChannel channel = new MethodChannel(getFlutterView(), MHB_CHANNEL);
        channel.invokeMethod("UploadMHBJson", obj);
    }

    private void openMhbFile(String file_key, Result result) {
        Context context = this.getApplicationContext();
        getMhbInstance().fetchData(file_key, new MHB.FetchDataCallback() {
            @Override
            public void onFetchDataSuccess(FileInputStream fis, String server_key) {
                AtomicFile outFile = new AtomicFile(new File(context.getExternalFilesDir(null), file_key));
                String jsonFileName = "";
                try {
                    writeToFile(fis, outFile.getBaseFile());
                    ZipFile zipFile = new ZipFile(outFile.getBaseFile());
                    Log.i(TAG, "zip file path:" + zipFile.getFile().getCanonicalPath());
                    if (zipFile.isValidZipFile() && zipFile.isEncrypted()) {
                        zipFile.setPassword(getFilePassword(server_key).toCharArray());
                    }

                    if (0 < zipFile.getFileHeaders().size()) {
                        zipFile.extractAll(Objects.requireNonNull(context.getExternalFilesDir(null)).getPath());

                        jsonFileName = ((FileHeader) zipFile.getFileHeaders().get(0)).getFileName();
                        String jsonContent = readJsonFile(
                                new File(context.getExternalFilesDir(null), jsonFileName).getPath());

                        // Log.i(TAG, "openMhbFile zip file json:"+jsonContent); // json too long log
                        // cat can handle
                        File persistfile = new File(context.getExternalFilesDir(null), jsonFileName);
                        // Log.i(TAG, "File Path: " + persistfile.getCanonicalPath());
                        // FileWriter writer = new FileWriter(persistfile.getPath());
                        // writer.write(jsonContent);
                        // writer.flush();
                        // writer.close();
                        Map<String, Object> obj = getReturnMessageObj("openMhbFile", "200", jsonContent, jsonFileName);
                        result.success(obj);
                        callFlutterUploadMHBJson(obj);
                        deleteOldFiles(outFile.getBaseFile(),
                                new File(context.getExternalFilesDir(null), jsonFileName));
                        Log.i(TAG, "onMHBDataSuccess");

                    }
                } catch (Exception e) {
                    Log.e(TAG, "openMhbFile onFetchDataSuccess error.", e);
                    deleteOldFiles(outFile.getBaseFile(), new File(context.getExternalFilesDir(null), jsonFileName));
                    Map<String, Object> obj = getReturnMessageObj("onMHBDataFail", "205", "無法解密產製的檔案", null);
                    result.success(obj);
                }
                // MethodChannel channel = new MethodChannel(getFlutterView(), MHB_CHANNEL);
                // Map mhbStatusMap = buildMHBStatusCode("200");
                // channel.invokeMethod("showMHBStatus", mhbStatusMap);
                Toast.makeText(context, "成功下載健康存摺！", Toast.LENGTH_LONG).show();
            }

            @Override
            public void onFetchDataFailure(String error_code) {
                Log.e(TAG, "onFetchDataFailure:" + error_code);
                // Map mhbStatusMap = buildMHBStatusCode(error_code);
                // MethodChannel channel = new MethodChannel(getFlutterView(), MHB_CHANNEL);
                // channel.invokeMethod("showMHBStatus", mhbStatusMap);
            }
        });
    }

    /**
     * 新版的產生金鑰方式
     * 
     * @param serverKey
     * @return
     */
    public static String getFilePassword(String serverKey) {
        String result = "";
        try {
            byte[] bytes = serverKey.getBytes(StandardCharsets.US_ASCII);
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM_NAME);
            KeySpec spec = new PBEKeySpec(BuildConfig.MHB_API_KEY.toCharArray(), bytes, 1000, 256);
            SecretKey tmp = factory.generateSecret(spec);
            result = Base64.encodeToString(tmp.getEncoded(), Base64.DEFAULT).trim();
        } catch (NoSuchAlgorithmException e) {
            Log.e(TAG, "getFilePassword getInstance error.", e);
        } catch (InvalidKeySpecException e) {
            Log.e(TAG, "getFilePassword generateSecret error.", e);
        }
        return result;
    }

    private Map buildMHBStatusCode(String code) {
        Map<String, String> returnCodeMap = new HashMap<>();
        switch (code) {
        case "200":
            returnCodeMap.put("code", "200");
            returnCodeMap.put("message", "成功下載健康存摺！");
            return returnCodeMap;
        case "102":
            returnCodeMap.put("code", "102");
            returnCodeMap.put("message", "Api_Key 錯誤。");
            return returnCodeMap;
        case "201":
            returnCodeMap.put("code", "201");
            returnCodeMap.put("message", "儲存空間不足。");
            return returnCodeMap;
        // case "202":
        // returnCodeMap.put("code","202");
        // returnCodeMap.put("message","詢問間隔須多於 60 秒。");
        // return returnCodeMap;
        case "205":
            returnCodeMap.put("code", "205");
            returnCodeMap.put("message", "取檔時 File_Ticket 不存在。");
            return returnCodeMap;
        case "206":
            returnCodeMap.put("code", "206");
            returnCodeMap.put("message", "取檔時 File_Ticket 驗證失敗。");
            return returnCodeMap;
        case "095":
            returnCodeMap.put("code", "095");
            returnCodeMap.put("message", "發生系統資料處理異常，請洽健保署聯絡窗口。");
            return returnCodeMap;
        case "096":
            returnCodeMap.put("code", "096");
            returnCodeMap.put("message", "不支援模擬器開發使用。");
            return returnCodeMap;
        case "097":
            returnCodeMap.put("code", "097");
            returnCodeMap.put("message", "發生不可預期之錯誤，請洽健保署服務裝窗口。");
            return returnCodeMap;
        case "098":
            returnCodeMap.put("code", "098");
            returnCodeMap.put("message", "無網路可使用，請確認是否開啟。");
            return returnCodeMap;
        case "099":
            returnCodeMap.put("code", "099");
            returnCodeMap.put("message", "系統忙碌中，請稍後再試。");
            return returnCodeMap;
        default:
            return returnCodeMap;
        }
    }

    @Override
    public void onMeetingStatusChanged(MeetingStatus meetingStatus, int errorCode, int internalErrorCode) {
        Log.i(TAG, "onMeetingStatusChanged, meetingStatus=" + meetingStatus + ", errorCode=" + errorCode
                + ", internalErrorCode=" + internalErrorCode);

        if(meetingStatus == MeetingStatus.MEETING_STATUS_FAILED && errorCode == MeetingError.MEETING_ERROR_CLIENT_INCOMPATIBLE) {
            Toast.makeText(this, "Version of ZoomSDK is too low!", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public void onZoomSDKLoginResult(long result) {

    }

    @Override
    public void onZoomSDKLogoutResult(long result) {

    }

    @Override
    public void onZoomIdentityExpired() {

    }

    @Override
    public void onZoomSDKInitializeResult(int errorCode, int internalErrorCode) {

    }

    /**
     * Fitness 進入點
     */
    public void getHealthInfo() {
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("requestPermissions")) {
                    try {
                        if (!GoogleSignIn.hasPermissions(GoogleSignIn.getLastSignedInAccount(NHIAndroidActivity.this),
                                initGoogleSignInOptionsExtension())) {
                            GoogleSignIn.requestPermissions(NHIAndroidActivity.this, // your activity
                                    100, GoogleSignIn.getLastSignedInAccount(NHIAndroidActivity.this),
                                    initGoogleSignInOptionsExtension());
                        }
                        result.success(true);
                    } catch (Exception e) {
                        result.error("Fitness", "Error occurred in permission.", null);
                    }
                } else if (call.method.equals("read")) {
                    try {
                        accessGoogleFit(result, ((Map) call.arguments));
                    } catch (Exception e) {
                        result.error("Fitness", "Error occurred in read data.", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Log.d(TAG, "onActivityResult: {} {}" + requestCode + resultCode);
    }

    /**
     * Fitness 同時要取得哪些資料
     */
    private GoogleSignInOptionsExtension initGoogleSignInOptionsExtension() {
        return FitnessOptions.builder()
                // 血壓
                .addDataType(HealthDataTypes.TYPE_BLOOD_PRESSURE, FitnessOptions.ACCESS_READ)
                .addDataType(HealthDataTypes.AGGREGATE_BLOOD_PRESSURE_SUMMARY, FitnessOptions.ACCESS_READ)
                // 運動
                .addDataType(DataType.TYPE_BODY_FAT_PERCENTAGE, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.TYPE_STEP_COUNT_DELTA, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.TYPE_WORKOUT_EXERCISE, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_STEP_COUNT_DELTA, FitnessOptions.ACCESS_READ)
                // 睡眠
                .addDataType(DataType.TYPE_ACTIVITY_SEGMENT, FitnessOptions.ACCESS_READ)
                // 心率
                .addDataType(DataType.TYPE_HEART_RATE_BPM, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_HEART_RATE_SUMMARY, FitnessOptions.ACCESS_READ) // 可取得心率平均 最大 最小值
                // 體重
                .addDataType(DataType.TYPE_WEIGHT, FitnessOptions.ACCESS_READ).build();
    }

    /**
     * Fitness 取得資料
     */
    private void accessGoogleFit(Result result, Map arguments) {

        DataReadRequest readRequest = new DataReadRequest.Builder().read(mapping(arguments.get("type").toString()))
                .setTimeRange((Long) arguments.get("date_from"), (Long) arguments.get("date_to"), TimeUnit.MILLISECONDS)
                .build();

        Fitness.getHistoryClient(this, GoogleSignIn.getLastSignedInAccount(this)).readData(readRequest)
                .addOnSuccessListener(new OnSuccessListener<DataReadResponse>() {
                    @Override
                    public void onSuccess(DataReadResponse dataReadResponse) {
                        // System.out.println(arguments);
                        if (dataReadResponse.getDataSets().size() > 0) {
                            for (DataSet dataSet : dataReadResponse.getDataSets()) {
                                if (dataSet.getDataType().equals(DataType.TYPE_ACTIVITY_SEGMENT)) {
                                    List toReturn = processDataForSleep(dataSet.getDataPoints());
                                    result.success(toReturn);
                                } else if (Arrays
                                        .asList(HealthDataTypes.TYPE_BLOOD_PRESSURE,
                                                HealthDataTypes.AGGREGATE_BLOOD_PRESSURE_SUMMARY)
                                        .contains(dataSet.getDataType())) {
                                    List toReturn = processDataForBloodPressure(dataSet.getDataPoints(),
                                            arguments.get("type").toString());
                                    result.success(toReturn);
                                } else if (Arrays.asList(DataType.TYPE_WEIGHT, DataType.TYPE_HEART_RATE_BPM)
                                        .contains(dataSet.getDataType())) {
                                    List toReturn = processDataByFloat(dataSet.getDataPoints());
                                    result.success(toReturn);
                                } else {
                                    List toReturn = processDataByInt(dataSet.getDataPoints());
                                    result.success(toReturn);
                                }
                            }
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                    }
                }).addOnCompleteListener(new OnCompleteListener<DataReadResponse>() {
                    @Override
                    public void onComplete(@NonNull Task<DataReadResponse> task) {
                    }
                });
    }

    protected DataType mapping(String typeFromFlutter) {
        DataType toReturn = null;
        switch (typeFromFlutter) {
        case "heart_rate":
            toReturn = DataType.TYPE_HEART_RATE_BPM;
            break;
        case "step_count":
            toReturn = DataType.TYPE_STEP_COUNT_DELTA;
            break;
        case "height":
            toReturn = DataType.TYPE_HEIGHT;
            break;
        case "weight":
            toReturn = DataType.TYPE_WEIGHT;
            break;
        case "distance":
            toReturn = DataType.TYPE_DISTANCE_DELTA;
            break;
        // google fit does not have this property, but apple health kit has it.
        case "energy":
            toReturn = DataType.TYPE_CALORIES_EXPENDED;
            break;
        case "blood_systolic":
        case "blood_diastolic":
            toReturn = HealthDataTypes.TYPE_BLOOD_PRESSURE;
            break;
        case "sleep":
            toReturn = DataType.TYPE_ACTIVITY_SEGMENT;
            break;
        }
        return toReturn;
    }

    protected List processDataByInt(List<DataPoint> dataPointList) {
        Map map;
        List toReturn = new LinkedList();
        for (DataPoint dataPoint : dataPointList) {
            map = new HashMap();
            for (Field field : dataPoint.getDataType().getFields()) {
                int value = dataPoint.getValue(field).asInt();
                long date_from = dataPoint.getStartTime(TimeUnit.MILLISECONDS);
                long date_to = dataPoint.getEndTime(TimeUnit.MILLISECONDS);
                map.put("date_from", date_from);
                map.put("date_to", date_to);
                map.put("value", value);
            }
            toReturn.add(map);
        }
        return toReturn;
    }

    protected List processDataByFloat(List<DataPoint> dataPointList) {
        Map map;
        List toReturn = new LinkedList();
        for (DataPoint dataPoint : dataPointList) {
            map = new HashMap();
            for (Field field : dataPoint.getDataType().getFields()) {
                float value = dataPoint.getValue(field).asFloat();
                long date_from = dataPoint.getStartTime(TimeUnit.MILLISECONDS);
                long date_to = dataPoint.getEndTime(TimeUnit.MILLISECONDS);
                map.put("date_from", date_from);
                map.put("date_to", date_to);
                map.put("value", value);
            }
            toReturn.add(map);
        }
        return toReturn;
    }

    /**
     * 取得睡眠資料 https://developers.google.com/fit/rest/v1/reference/activity-types
     * Still (not moving)* 3 Walking* 7 Running* 8 Sleeping 72 Other (unclassified
     * fitness activity) 108 Light sleep 109 Deep sleep 110 REM sleep 111
     */
    protected List processDataForSleep(List<DataPoint> dataPointList) {
        Map map;
        List toReturn = new LinkedList();
        for (DataPoint dataPoint : dataPointList) {
            map = new HashMap();
            for (Field field : dataPoint.getDataType().getFields()) {
                int value = dataPoint.getValue(field).asInt();
                long date_from = dataPoint.getStartTime(TimeUnit.MILLISECONDS);
                long date_to = dataPoint.getEndTime(TimeUnit.MILLISECONDS);

                /**
                 * 目前小米為對應ios呈現 將109歸成3(新定義) 110、111歸成1(睡著) 112歸成2(清醒) 每筆紀錄再產生對應的0(床上時間)
                 */
                switch (value) {
                case 72:
                case 109:
                case 110:
                case 111:
                case 112:
                    map.put("date_from", date_from);
                    map.put("date_to", date_to);
                    map.put("value", value);
                    toReturn.add(map);
                    break;
                }
            }
        }
        return toReturn;
    }

    /**
     * 取得血壓 dataPoint.getDataType().getFields(), has four fields, sort as follows,
     * systolic, diastolic, and so on. In this case, only need 0, 1.
     */
    protected List processDataForBloodPressure(List<DataPoint> dataPointList, String type) {
        Map map;
        List toReturn = new LinkedList();
        for (DataPoint dataPoint : dataPointList) {
            int index;
            if ("blood_systolic".equals(type)) {
                index = 0;
            } else if ("blood_diastolic".equals(type)) {
                index = 1;
            } else {
                break;
            }
            map = new HashMap();
            List<Field> fields = dataPoint.getDataType().getFields();
            float value = dataPoint.getValue(fields.get(index)).asFloat();
            long date_to = dataPoint.getEndTime(TimeUnit.MILLISECONDS);
            long date_from = date_to;
            map.put("date_from", date_from);
            map.put("date_to", date_to);
            map.put("value", value);
            toReturn.add(map);
        }
        return toReturn;
    }

    @Override
    public void onBackPressed() {
        return;
    }

    @Override
    public void onMeetingNeedPasswordOrDisplayName(boolean needPassword, boolean needDisplayName, InMeetingEventHandler handler) {

    }

    @Override
    public void onWebinarNeedRegister() {

    }

    @Override
    public void onJoinWebinarNeedUserNameAndEmail(InMeetingEventHandler handler) {

    }

    @Override
    public void onMeetingNeedColseOtherMeeting(InMeetingEventHandler handler) {

    }

    @Override
    public void onMeetingFail(int errorCode, int internalErrorCode) {

    }

    @Override
    public void onMeetingLeaveComplete(long ret) {

    }

    @Override
    public void onMeetingUserJoin(List<Long> userList) {
        Log.d(TAG, "Hi~~~~~");
    }

    @Override
    public void onMeetingUserLeave(List<Long> userList) {
        Toast.makeText(this, "User Leaving", Toast.LENGTH_LONG).show();
        zoomChannelResult.success("ByBy");
    }

    @Override
    public void onMeetingUserUpdated(long userId) {

    }

    @Override
    public void onMeetingHostChanged(long userId) {

    }

    @Override
    public void onMeetingCoHostChanged(long userId) {

    }

    @Override
    public void onActiveVideoUserChanged(long userId) {

    }

    @Override
    public void onActiveSpeakerVideoUserChanged(long userId) {

    }

    @Override
    public void onSpotlightVideoChanged(boolean on) {

    }

    @Override
    public void onUserVideoStatusChanged(long userId) {

    }

    @Override
    public void onUserNetworkQualityChanged(long userId) {

    }

    @Override
    public void onMicrophoneStatusError(InMeetingAudioController.MobileRTCMicrophoneError error) {

    }

    @Override
    public void onUserAudioStatusChanged(long userId) {

    }

    @Override
    public void onHostAskUnMute(long userId) {

    }

    @Override
    public void onUserAudioTypeChanged(long userId) {

    }

    @Override
    public void onMyAudioSourceTypeChanged(int type) {

    }

    @Override
    public void onLowOrRaiseHandStatusChanged(long userId, boolean isRaiseHand) {

    }

    @Override
    public void onMeetingSecureKeyNotification(byte[] key) {

    }

    @Override
    public void onChatMessageReceived(InMeetingChatMessage msg) {

    }

    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }
}
