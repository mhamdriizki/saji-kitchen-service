package com.sajikitchen.saji_cashier.services.admin.s3;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.core.sync.RequestBody;

import java.io.IOException;
import java.net.URL;
import java.util.UUID;

@Service
public class S3Service {

    private final S3Client s3Client;
    private final String bucketName;
    private final Region region;

    // Injeksi nilai dari application.properties
    public S3Service(@Value("${aws.accessKeyId}") String accessKey,
                     @Value("${aws.secretKey}") String secretKey,
                     @Value("${aws.region}") String region,
                     @Value("${aws.s3.bucketName}") String bucketName) {

        this.bucketName = bucketName;
        this.region = Region.of(region);

        AwsBasicCredentials credentials = AwsBasicCredentials.create(accessKey, secretKey);
        this.s3Client = S3Client.builder()
                .region(this.region)
                .credentialsProvider(StaticCredentialsProvider.create(credentials))
                .build();
    }

    /**
     * Mengunggah file ke S3 dan mengembalikan URL publiknya.
     * @param file File yang akan diunggah
     * @return URL publik dari file yang diunggah
     * @throws IOException Jika terjadi error saat membaca file
     */
    public String uploadFile(MultipartFile file) throws IOException {
        // Buat nama file yang unik untuk menghindari konflik
        String extension = "";
        String originalFilename = file.getOriginalFilename();
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFileName = UUID.randomUUID().toString() + extension;

        // Buat request untuk S3
        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(uniqueFileName)
                .contentType(file.getContentType())
                .build();

        // Unggah file
        s3Client.putObject(putObjectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

        // Kembalikan URL publik
        return String.format("https://%s.s3.%s.amazonaws.com/%s", bucketName, this.region.id(), uniqueFileName);
    }

    public void deleteFile(String fileUrl) {
        if (fileUrl == null || fileUrl.isEmpty()) {
            return; // Tidak ada yang perlu dihapus
        }

        try {
            // Ekstrak 'key' (nama file) dari URL lengkap
            // URL: https://[bucket].s3.[region].amazonaws.com/[key]
            URL url = new URL(fileUrl);
            String fileKey = url.getPath().substring(1); // Hapus '/' di awal

            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket(bucketName)
                    .key(fileKey)
                    .build();

            s3Client.deleteObject(deleteObjectRequest);

        } catch (Exception e) {
            // Catat error tapi jangan hentikan proses utama
            // Mungkin file-nya sudah tidak ada atau URL-nya korup
            System.err.println("Gagal menghapus file dari S3: " + e.getMessage());
        }
    }
}
