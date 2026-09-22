<template>
  <div style="padding: 20px">
    <h1>考试系统前端已运行</h1>
    <el-button type="primary" @click="testBackend">测试后端连接</el-button>
    <div v-if="user" style="margin-top: 20px">
      <pre>{{ user }}</pre>
    </div>
    <div v-if="error" style="margin-top: 20px; color: red">
      {{ error }}
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const user = ref(null)
const error = ref('')

const testBackend = async () => {
  error.value = ''
  try {
    const res = await axios.get('http://localhost:8080/api/test/user/admin')
    user.value = res.data
  } catch (e) {
    error.value = '请求失败: ' + (e.response?.data?.message || e.message)
  }
}
</script>