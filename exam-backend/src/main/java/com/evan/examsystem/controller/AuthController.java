package com.evan.examsystem.controller;

import com.evan.examsystem.common.Result;
import com.evan.examsystem.dto.LoginDTO;
import com.evan.examsystem.dto.RegisterDTO;
import com.evan.examsystem.entity.User;
import com.evan.examsystem.service.AuthService;
import com.evan.examsystem.vo.LoginVO;
import com.evan.examsystem.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthService authService;

    /**
     * 登录
     * @param loginDTO
     * @return
     */
    @PostMapping("/login")
    public Result<LoginVO>login(@RequestBody LoginDTO loginDTO) {
        return Result.success(authService.login(loginDTO));
    }

    /**
     * 注册
     * @param registerDTO
     * @return
     */
    @PostMapping("/register")
    public Result<Void>register(@RequestBody RegisterDTO registerDTO) {
        authService.register(registerDTO);
        return Result.success();
    }

    /**
     * 获取当前用户
     * @param request
     * @return
     */
    @GetMapping("/me")
    public Result<UserVO>me(HttpServletRequest request) {
        Long userId=(Long)request.getAttribute("userId");
        return Result.success(authService.getCurrentUser(userId));
    }

    /**
     * 退出登录
     * @return
     */
    @PostMapping("/logout")
    public Result<Void>logout(){
        return Result.success();
    }

}
