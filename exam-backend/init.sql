CREATE DATABASE exam_system DEFAULT CHARACTER SET utf8mb4;

USE exam_system;

-- 用户表（学生和管理员共用，用 role 区分）
CREATE TABLE `user` (
                        `id` BIGINT NOT NULL AUTO_INCREMENT,
                        `username` VARCHAR(50) NOT NULL,
                        `password` VARCHAR(100) NOT NULL,
                        `role` VARCHAR(20) DEFAULT 'student',  -- student / admin
                        `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB;

-- 试卷表
CREATE TABLE `exam_paper` (
                              `id` BIGINT NOT NULL AUTO_INCREMENT,
                              `name` VARCHAR(200) NOT NULL,
                              `duration_minutes` INT NOT NULL,        -- 考试时长（分钟）
                              `total_score` INT DEFAULT 100,
                              `start_time` DATETIME,                   -- 考试开始时间
                              `end_time` DATETIME,                     -- 考试截止时间
                              `status` INT DEFAULT 0,                  -- 0未开始 1进行中 2已结束
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 试题表
CREATE TABLE `exam_question` (
                                 `id` BIGINT NOT NULL AUTO_INCREMENT,
                                 `paper_id` BIGINT NOT NULL,
                                 `content` TEXT NOT NULL,                 -- 题目内容
                                 `options` JSON,                          -- 选项（JSON格式）
                                 `correct_answer` VARCHAR(200),
                                 `score` INT DEFAULT 5,
                                 `type` INT DEFAULT 1,                    -- 1单选 2多选 3判断
                                 PRIMARY KEY (`id`),
                                 KEY `idx_paper_id` (`paper_id`)
) ENGINE=InnoDB;

-- 考试记录表
CREATE TABLE `exam_record` (
                               `id` BIGINT NOT NULL AUTO_INCREMENT,
                               `paper_id` BIGINT NOT NULL,
                               `user_id` BIGINT NOT NULL,
                               `total_score` INT DEFAULT 0,
                               `start_time` DATETIME,
                               `submit_time` DATETIME,
                               `status` INT DEFAULT 0,                  -- 0进行中 1已交卷
                               PRIMARY KEY (`id`),
                               KEY `idx_paper_user` (`paper_id`, `user_id`)
) ENGINE=InnoDB;

INSERT INTO `user` (`username`, `password`, `role`) VALUES ('admin', '123456', 'admin');
INSERT INTO `exam_paper` (`name`, `duration_minutes`, `total_score`, `status`)
VALUES ('测试考试', 30, 100, 1);