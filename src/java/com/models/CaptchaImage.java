/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hp
 */
@WebServlet("/captcha-image")
public class CaptchaImage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập nội dung phản hồi là hình ảnh JPG
        response.setContentType("image/jpg");

        int iTotalChars = 6;
        int iHeight = 40;
        int iWidth = 150;
        Font fntStyle1 = new Font("Arial", Font.BOLD, 30);
        Font fntStyle2 = new Font("Arial", Font.BOLD, 20);
        Random randChars = new Random();

        // Tạo mã CAPTCHA ngẫu nhiên
        String sImageCode = (Long.toString(Math.abs(randChars.nextLong()), 36)).substring(0, iTotalChars);

        // Lưu mã CAPTCHA vào session
        request.getSession().setAttribute("captcha", sImageCode);

        // Tạo một hình ảnh trống
        BufferedImage bufferedImage = new BufferedImage(iWidth, iHeight, BufferedImage.TYPE_INT_RGB);
        Graphics g = bufferedImage.getGraphics();

        // Thiết lập màu nền cho hình ảnh
        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, 0, iWidth, iHeight);

        // Vẽ mã CAPTCHA lên hình ảnh
        g.setFont(fntStyle1);
        g.setColor(Color.BLACK);
        g.drawString(sImageCode, 20, 30);

        // Tạo một số đường nhiễu để tăng độ bảo mật
        g.setFont(fntStyle2);
        for (int i = 0; i < 15; i++) {
            g.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));
            g.drawLine(randChars.nextInt(iWidth), randChars.nextInt(iHeight), randChars.nextInt(iWidth), randChars.nextInt(iHeight));
        }

        // Đóng đồ họa và gửi hình ảnh ra cho phản hồi
        g.dispose();
        ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
    }
      @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
