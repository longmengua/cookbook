package com.h2uclub.hi365.common;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class StreamUtil {
    public static void copyStreams(InputStream inStream, OutputStream outStream)
            throws IOException {
        int data;
        while ((data = inStream.read()) != -1) {
            outStream.write(data);
        }
    }

    public static void closeStream(InputStream inStream) {
        if (inStream != null) {
            try {
                inStream.close();
            } catch (IOException e) {
                // ignore
            }
        }
    }

    public static void closeStream(OutputStream outStream) {
        if (outStream != null) {
            try {
                outStream.close();
            } catch (IOException e) {
                // ignore
            }
        }
    }
}

