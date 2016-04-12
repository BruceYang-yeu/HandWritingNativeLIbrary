package com.gdbbk.dw.handwritinginput;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

/**
 * Created by Administrator on 16.4.6.
 */
public class LipiTKJNIInterface {
    private String _lipiDirectory;
    private String _project;
    private static final String TAG ="LipiTKJNIInterface";
    static
    {
        try {
            System.loadLibrary("lipitk");
            //System.load("/system/lib/liblipitk.so");
        } catch (Exception ex) {
            System.out.println("LipiTKJNIInterface" + ex.getMessage());
        }
    }

    //  Initializes the interface with a directory to look for projects in
    //  	the name of the project to use for recognition, and the name
    //  	of the ShapeRecognizer to use.
    public LipiTKJNIInterface(String lipiDirectory, String project) {
        _lipiDirectory = lipiDirectory;
        _project = project;
    }

    public String getSymbolName(int id,String project_config_dir)
    {
        String line;
        int temp;
        String [] splited_line= null;
        try
        {
            File map_file = new File(project_config_dir+"unicodeMapfile_alphanumeric.ini");
            BufferedReader readIni = new BufferedReader(new FileReader(map_file));
            readIni.readLine();
            readIni.readLine();
            readIni.readLine();
            readIni.readLine();
            while((line=readIni.readLine())!=null)
            {
                splited_line = line.split(" ");
                splited_line[0] = splited_line[0].substring(0, splited_line[0].length()-1); //trim out = sign
                if(splited_line[0].equals((new Integer(id)).toString()))
                {
                    splited_line[1] = splited_line[1].substring(2);
                    temp = Integer.parseInt(splited_line[1], 16);
    i                return String.valueOf((char)temp);
                }
            }
        }
        catch(Exception ex)
        {
            return "-1";
        }
        return "0";
    }

    public void initialize() {
        initializeNative(_lipiDirectory, _project);
    }

    public LipitkResult[] recognize(Stroke[] strokes) {
        LipitkResult[] results = recognizeNative(strokes, strokes.length);

        for (LipitkResult result : results)
            System.out.println("jni", "ShapeID = " + result.Id + " Confidence = " + result.Confidence);

        return results;
    }

    // Initializes the LipiTKEngine in native code
    private native void initializeNative(String lipiDirectory, String project);

    // Returns a list of results when recognizing the given list of strokes
    private native LipitkResult[] recognizeNative(Stroke[] strokes, int numJStrokes);

    public String getLipiDirectory() {
        return _lipiDirectory;
    }

}
