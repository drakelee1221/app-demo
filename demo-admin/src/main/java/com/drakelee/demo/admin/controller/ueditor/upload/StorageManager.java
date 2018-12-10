

package com.drakelee.demo.admin.controller.ueditor.upload;

import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.State;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.base.components.common.dto.io.FileDTO;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.Logs;
import com.base.components.common.boot.SpringContextUtil;
import com.drakelee.demo.feign.client.pm.OssQiniuClient;
import org.apache.commons.io.FileUtils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

public class StorageManager {
	public static final int BUFFER_SIZE = 8192;

	public StorageManager() {
	}

	public static State saveBinaryFile(byte[] data, String path) {
		File file = new File(path);

		State state = valid(file);

		if (!state.isSuccess()) {
			return state;
		}

		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(file));
			bos.write(data);
			bos.flush();
			bos.close();
		} catch (IOException ioe) {
			return new BaseState(false, AppInfo.IO_ERROR);
		}

		state = new BaseState(true, file.getAbsolutePath());
		state.putInfo( "size", data.length );
		state.putInfo( "title", file.getName() );
		return state;
	}

	public static State saveFileByInputStream(InputStream is, String path,
			long maxSize) {
		State state;

		File tmpFile = getTmpFile();

		byte[] dataBuf = new byte[ 2048 ];
		BufferedInputStream bis = new BufferedInputStream(is, StorageManager.BUFFER_SIZE);

		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(tmpFile), StorageManager.BUFFER_SIZE);

			int count;
			while ((count = bis.read(dataBuf)) != -1) {
				bos.write(dataBuf, 0, count);
			}
			bos.flush();
			bos.close();

			if (tmpFile.length() > maxSize) {
				tmpFile.delete();
				return new BaseState(false, AppInfo.MAX_SIZE);
			}

			state = saveTmpFile(tmpFile, path);

//			if (!state.isSuccess()) {
				tmpFile.delete();
//			}

			return state;
			
		} catch (IOException e) {
			Logs.get().error("", e);
		}
		return new BaseState(false, AppInfo.IO_ERROR);
	}

	public static State saveFileByInputStream(InputStream is, String path) {
		State state;

		File tmpFile = getTmpFile();

		byte[] dataBuf = new byte[ 2048 ];
		BufferedInputStream bis = new BufferedInputStream(is, StorageManager.BUFFER_SIZE);

		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(tmpFile), StorageManager.BUFFER_SIZE);

			int count;
			while ((count = bis.read(dataBuf)) != -1) {
				bos.write(dataBuf, 0, count);
			}
			bos.flush();
			bos.close();

			state = saveTmpFile(tmpFile, path);

//			if (!state.isSuccess()) {
				tmpFile.delete();
//			}

			return state;
		} catch (IOException e) {
			Logs.get().error("", e);
		}
		return new BaseState(false, AppInfo.IO_ERROR);
	}

	private static File getTmpFile() {
		File tmpDir = FileUtils.getTempDirectory();
		String tmpFileName = (Math.random() * 10000 + "").replace(".", "");
		return new File(tmpDir, tmpFileName);
	}

	private static State saveTmpFile(File tmpFile, String path) {
		State state = null;
		File targetFile = new File(path);

		if (targetFile.canWrite()) {
			return new BaseState(false, AppInfo.PERMISSION_DENIED);
		}
		boolean uploaderror = true;
		ObjectNode result = null;
		try {
			byte[] bytes = Files.readAllBytes(tmpFile.toPath());
			if(bytes.length > 0){
				FileDTO dto = new FileDTO();
				dto.setPrivateFile(Boolean.FALSE);
				dto.setUserId(TokenThreadLocal.getTokenObjNonNull().objId().toString());
				dto.setTempFile(Boolean.TRUE);
				dto.setFileName(targetFile.getName());
				dto.setUploadBytes(bytes);
				OssQiniuClient client = SpringContextUtil.getBean(OssQiniuClient.class);
				result = client.serverUploadFile(dto);
				uploaderror = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(uploaderror){
			try {
				FileUtils.moveFile(tmpFile, targetFile);
			} catch (IOException e) {
				return new BaseState(false, AppInfo.IO_ERROR);
			}
		}else{
			state = new BaseState(true);
			state.putInfo( "size", targetFile.length() );
			state.putInfo( "title", targetFile.getName() );
			state.putInfo( "url", result.get("url").asText() );

		}

		return state;
	}

	private static State valid(File file) {
		File parentPath = file.getParentFile();

		if ((!parentPath.exists()) && (!parentPath.mkdirs())) {
			return new BaseState(false, AppInfo.FAILED_CREATE_FILE);
		}

		if (!parentPath.canWrite()) {
			return new BaseState(false, AppInfo.PERMISSION_DENIED);
		}

		return new BaseState(true);
	}
}
