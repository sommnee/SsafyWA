<script setup>
import { ref } from 'vue';
import NavBar from './components/layout/NavBar.vue';
import SideBar from './components/layout/SideBar.vue';
import { RouterView } from 'vue-router';
import "@/assets/fonts.css";
import ChatSpeedDial from './components/chat/ChatSpeedDial.vue';

const sidebarOpen = ref(false);

function toggleSidebar() {
  sidebarOpen.value = !sidebarOpen.value;
}
</script>

<template>
  
  <v-app>
    <NavBar @toggle-sidebar="toggleSidebar"/>
    <div class="left-sidebar-bg"></div>
    <v-navigation-drawer v-model="sidebarOpen" app left temporary class="side-bar">
      <SideBar ref="sidebarRef"/>
    </v-navigation-drawer>
    <v-main class="main-content">
      <RouterView />
    </v-main>
    <ChatSpeedDial />
  </v-app>
</template>

<style scoped>
.v-application--wrap {
  padding-top: 64px; /* NavBar height */
}

.main-content {
  position: relative;
  padding-top: 0px;
  margin-left: 64px; /* 왼쪽 여백을 left-sidebar-bg 너비만큼 설정 */
}

.side-bar {
  background-color: #f5f5f5; /* 원하는 배경색으로 변경 가능 */
}
.left-sidebar-bg {
  position: fixed;
  top: 0;
  left: 0;
  width: 64px; /* 원하는 너비로 설정 */
  height: 100%;
  background-color: #87CEEB; /* 하늘색 배경 설정 */
  z-index: 1;
}

</style>
