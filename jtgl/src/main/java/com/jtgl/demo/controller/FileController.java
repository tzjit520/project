package com.jtgl.demo.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jtgl.demo.model.FileMeta;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;

@RestController
@RequestMapping("/api/v1/file")
public class FileController extends BaseController {

    @Value("${uploadPath}")
    private String uploadPath;

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public @ResponseBody Result<List<FileMeta>> upload(MultipartHttpServletRequest request) {
        List<FileMeta> files = new LinkedList<FileMeta>();
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            FileMeta fileMeta = new FileMeta();
            fileMeta.setName(mpf.getOriginalFilename());
            fileMeta.setSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setType(mpf.getContentType());

            try {
                fileMeta.setBytes(mpf.getBytes());
                File folder = new File(uploadPath + "images/");
                if (!folder.exists()) {
                    folder.mkdirs();
                }
                String location = uploadPath + "images/" + mpf.getOriginalFilename();
                File file = new File(location);
                System.out.println(location);
                //拷贝路径
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(file));

                //设置上传路径
                fileMeta.setLocation("images/" + mpf.getOriginalFilename());

            } catch (Exception e) {
                e.printStackTrace();
            }
            files.add(fileMeta);
        }
        return new ResultBuilder<List<FileMeta>>().data(files).build();
    }

    //可以通过增加参数的方式 或者新增一个方法上传不同类型的文件,也可自定义文件夹目录
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public @ResponseBody Result<List<FileMeta>> uploadFile(MultipartHttpServletRequest request) {
        List<FileMeta> files = new LinkedList<FileMeta>();
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            FileMeta fileMeta = new FileMeta();
            fileMeta.setName(mpf.getOriginalFilename());
            fileMeta.setSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setType(mpf.getContentType());

            try {
                fileMeta.setBytes(mpf.getBytes());
                File folder = new File(uploadPath + "files/");
                if (!folder.exists()) {
                    folder.mkdirs();
                }
                String location = uploadPath + "files/" + mpf.getOriginalFilename();
                File file = new File(location);
                System.out.println(location);
                //拷贝路径
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(file));

                //设置上传路径
                fileMeta.setLocation("files/" + mpf.getOriginalFilename());

            } catch (Exception e) {
                e.printStackTrace();
            }
            files.add(fileMeta);
        }
        return new ResultBuilder<List<FileMeta>>().data(files).build();
    }

    @RequestMapping(value = "/download", method = RequestMethod.POST)
    public void download(HttpServletResponse response) {
        //支持中文名并即时下载 不占用temp空间
        String realPath = uploadPath +"/test/测试下载.docx";
        //可自定义文件名
        String fileName = "测试下载.docx";

        File file = new File(realPath);
        BufferedInputStream bis = null;
        FileInputStream fis = null;

        if (file.exists()) {
            try {

                response.setCharacterEncoding("utf-8");
                response.setContentType("application/msword");
                //不同的文件类型需要更改不同的content type，例如pdf，可自行搜索contenttype列表
                //response.setContentType("application/pdf");
                //response.setContentType("image/jpeg");
                fileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString());
                response.addHeader("Content-Disposition", "attachment;fileName=" +fileName);// 设置文件名
                byte[] buffer = new byte[1024];
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                OutputStream os = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    os.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
