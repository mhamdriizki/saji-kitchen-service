package com.sajikitchen.saji_cashier.services.email;

import com.sajikitchen.saji_cashier.models.InventoryItem;
import com.sajikitchen.saji_cashier.models.Order;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailServiceImpl.class);

    private final JavaMailSender mailSender;
    private final TemplateEngine templateEngine;

    @Value("${spring.mail.username}")
    private String mailFrom;

    public EmailServiceImpl(JavaMailSender mailSender, TemplateEngine templateEngine) {
        this.mailSender = mailSender;
        this.templateEngine = templateEngine;
    }

    @Override
    public void sendOrderConfirmationEmail(String to, Order order, byte[] pdfAttachment) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setTo(to);
            helper.setFrom(mailFrom);
            helper.setSubject("Detail Pesanan Saji Kitchen #" + order.getOrderId());

            // Proses template Thymeleaf
            Context context = new Context();
            context.setVariable("order", order);
            String htmlContent = templateEngine.process("receipt-template", context); // Sesuaikan path jika perlu
            helper.setText(htmlContent, true);

            // Lampirkan PDF
            helper.addAttachment("Struk-" + order.getOrderId() + ".pdf", new ByteArrayResource(pdfAttachment));

            mailSender.send(mimeMessage);
            log.info("Confirmation email sent successfully to {} for order {}", to, order.getOrderId());

        } catch (MessagingException e) {
            log.error("Failed to send confirmation email for order {}: {}", order.getOrderId(), e.getMessage());
            // Lemparkan exception custom agar transaksi bisa di-rollback jika diperlukan,
            // atau tangani sesuai kebutuhan bisnis.
            throw new RuntimeException("Error sending email", e);
        }
    }

    // --- METHOD BARU UNTUK NOTIFIKASI STOK ---
    @Override
    public void sendLowStockNotification(InventoryItem item) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "UTF-8");

            // Ganti dengan email owner di application.properties
            helper.setTo("owner@sajikitchen.com");
            helper.setFrom(mailFrom);
            helper.setSubject("[PERINGATAN] Stok Rendah - " + item.getName());

            String emailContent = String.format(
                    "<h3>Peringatan Stok Rendah</h3>" +
                            "<p>Stok untuk item <b>%s</b> telah mencapai atau di bawah ambang batas.</p>" +
                            "<ul>" +
                            "<li>Stok Saat Ini: <b>%d</b></li>" +
                            "<li>Ambang Batas: <b>%d</b></li>" +
                            "</ul>" +
                            "<p>Harap segera lakukan pengadaan ulang.</p>",
                    item.getName(), item.getQuantity(), item.getThreshold()
            );
            helper.setText(emailContent, true);

            mailSender.send(mimeMessage);
            log.info("Notifikasi stok rendah berhasil dikirim untuk item: {}", item.getName());

        } catch (MessagingException e) {
            log.error("Gagal mengirim notifikasi stok rendah untuk item {}: {}", item.getName(), e.getMessage());
        }
    }
}