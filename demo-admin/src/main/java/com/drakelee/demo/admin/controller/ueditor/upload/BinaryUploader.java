

package com.drakelee.demo.admin.controller.ueditor.upload;

import com.baidu.ueditor.PathFormat;
import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.FileType;
import com.baidu.ueditor.define.State;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class BinaryUploader {

	public static final State save(HttpServletRequest request,
																 Map<String, Object> conf) {
		boolean isAjaxUpload = request.getHeader( "X_Requested_With" ) != null;

		if (!ServletFileUpload.isMultipartContent(request)) {
			return new BaseState(false, AppInfo.NOT_MULTIPART_CONTENT);
		}

		ServletFileUpload upload = new ServletFileUpload(
			new DiskFileItemFactory());

		if ( isAjaxUpload ) {
			upload.setHeaderEncoding( "UTF-8" );
		}

		try {
			//创建一个通用的多部分解析器
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			//判断 request 是否有文件上传,即多部分请求
			if(multipartResolver.isMultipart(request)){
				//转换成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
				//取得request中的所有文件名
				Iterator<String> iter = multiRequest.getFileNames();
				while(iter.hasNext()){
					//取得上传文件
					MultipartFile file = multiRequest.getFile(iter.next());
					if(file != null){
						//取得当前上传文件的文件名称
						String savePath = (String) conf.get("savePath");
						String originFileName = file.getOriginalFilename();
						System.out.println(originFileName);
						String suffix = FileType.getSuffixByFilename(originFileName);
						originFileName = originFileName.substring(0,
																											originFileName.length() - suffix.length());
						savePath = savePath + suffix;

						long maxSize = ((Long) conf.get("maxSize")).longValue();

						if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
							return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
						}

						savePath = PathFormat.parse(savePath, originFileName);

						String physicalPath = (String) conf.get("rootPath") + savePath;
						System.out.println(physicalPath);
						InputStream is = file.getInputStream();
						State storageState = StorageManager.saveFileByInputStream(is,
																																			physicalPath, maxSize);
						is.close();

						if (storageState.isSuccess()) {
//							storageState.putInfo("url", PathFormat.format(savePath));
							storageState.putInfo("type", suffix);
							storageState.putInfo("original", originFileName + suffix);
						}

						return storageState;
					}
					else{
						return new BaseState(false, AppInfo.NOTFOUND_UPLOAD_DATA);
					}
				}
			}
		}
		catch (IOException e) {
			return new BaseState(false, AppInfo.PARSE_REQUEST_ERROR);
		}
		return new BaseState(false, AppInfo.IO_ERROR);
	}

	private static boolean validType(String type, String[] allowTypes) {
		List<String> list = Arrays.asList(allowTypes);

		return list.contains(type);
	}
}
