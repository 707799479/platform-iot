package com.zmkj.platform.util;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.UUID;

public class ImgUpload {

    public static String[] startUpload(MultipartFile files[],String path){
        //String uploadPath = request.getSession().getServletContext().getRealPath("upload" + File.separator + "img");
        String[] info = new String[files.length];
        String[] imgPath = new String[files.length];
        System.out.println("图片工具类："+files.length);
        if (files != null && files.length >= 1) {
            int i = 0;
            for (MultipartFile file : files) {
                System.out.println("图片工具类："+i);
                if (!file.isEmpty()) {
                    //获得文件名
                    String oldFileName = file.getOriginalFilename();
                    //使用Apache提供的方法来获取文件后缀
                    String prefix = FilenameUtils.getExtension(oldFileName);
                    int filesize = 100000000;
                    String fileName = "";
                    if (file.getSize() > filesize) {
                        info[i] = "错误：上传的文件不能大于10m";
                        System.out.println("图片上传大小超出");
                    } else if (prefix.equalsIgnoreCase("jpg")
                            || prefix.equalsIgnoreCase("png")
                            || prefix.equalsIgnoreCase("jpeg")
                            || prefix.equalsIgnoreCase("gif")) {
                        //定义新的文件名
                        fileName = UUID.randomUUID().toString() + "." + prefix;
                        File targetFile = new File(path ,fileName);
                        //如果目录不纯在 就创建
                        if (!targetFile.exists()) {
                            targetFile.getParentFile().mkdirs();
                        }
                        try {
                            //执行这个方法 把图片添加到服务器
                            file.transferTo(targetFile);
                        } catch (Exception e) {
                            e.printStackTrace();
                            info[i] = "错误：上传文件失败";
                            System.out.println("图片上传失败");
                        }
                        imgPath[i] =  fileName;

                    } else {
                        info[i] = "错误：图片格式错误";
                        System.out.println("图片上传格式错误");
                    }
                }else{
                    System.out.println("图片上传空文件");
                }
                info[i] = imgPath[i];

                i++;
            }
        }
        return info;
    }
}
