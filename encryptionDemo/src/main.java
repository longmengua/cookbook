import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class main {
    public static void main(String... a) throws Exception {
        String password = "er6nzx10rz1000";
        main m = new main();
//        String encryption = m.Encrypt("BC21571100, BC24497100, AC376011G0, BC17125100, AC37991100, AC57122100, A020557100, AC33064100, AC58202100, A011084100, AC14277100, NC07755421, AC46990421, N007592100, AC34112100, AC58577100, AC15024100, AC47990421, AC48471421, A027569100, A034819100, AC26278100, AC32619100, AC49397100, BC19624100, AC44977100, AC42017100, AC05712100", password);
//        System.out.println(encryption);
//        System.out.println("-----------");
//        System.out.println("rO5ExHgqVky7bG6rDJvqIMRcqNg9WwdyVii4CS468BjIXP+WZGHLe9YoYHDCMRlxcU+vts7uu67KCZqRdQf+XB5lpRpUB6uKgZo0OUnO0/Bx51VhKZL+bLufhnxz5gk6xTHfFR2Li/fTy2ZTnNWWpS+/IKBfLAmStRy9ScgYA3MljjHDtJi6z2ATVmjw4Nh6YsqdengWHMJPSiJFKnuaygMGcnXGNPwG9oic3Y0Co78Lq5xE67N2lDY51LHmhmZGLdKMUDIYcnIJQV0WH4xAiUxTFVt+5wNbEppAttyp7w6Vsy7Bg5hmgJN2TkAPZ94/A+Cx2qucjp6xEsWUQfGQ1KeWf/1zPZjU5x6uVdfTwosUXqZBtZb21ryU3984qaFpDeJJXI6RQB95WhxdtfikZ+Gvg/C1xb13BJ01JupFnu/7WLuzS+Zlp0gXSlsxCcG6".equals(encryption));
//        System.out.println("-----------");
//        String decryption = m.Decrypt(encryption, password);
//        System.out.println(decryption);

        String encryption = m.Encrypt("1.05, 1.21", password);
        System.out.println(encryption);
        System.out.println("-----------");
        System.out.println("bB/n1byknOnYPi7UOnjXhw==".equals(encryption));
        System.out.println("-----------");
        String decryption = m.Decrypt(encryption, password);
        System.out.println(decryption);
        decryption = m.Decrypt("t415finb7V/7PoPO8fgI3A==", password);
        System.out.println(decryption);
    }

    public String Decrypt(String text, String key) throws Exception {
        Cipher cipher = Cipher.getInstance
                ("AES/CBC/PKCS5Padding"); //this parameters should not be changed
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if (len > keyBytes.length)
            len = keyBytes.length;
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
        byte[] results = new byte[text.length()];
        //android.util.Base64.decode() decoder = new android.util.Base64;
        try {
            results = cipher.doFinal(Base64.getDecoder().decode(text));
        } catch (Exception e) {
//            Log.i("Erron in Decryption", e.toString());
        }
        //Log.i("Data", new String(results, "UTF-8"));
        return new String(results, "UTF-8"); // it returns the result as a String
    }

    public String Encrypt(String text, String key) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if (len > keyBytes.length)
            len = keyBytes.length;
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

        byte[] results = cipher.doFinal(text.getBytes("UTF-8"));

        //BASE64Encoder encoder = new BASE64Encoder();
        return Base64.getEncoder().encodeToString(results); // it returns the result as a String
    }
}
