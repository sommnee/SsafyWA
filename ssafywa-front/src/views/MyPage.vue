<script setup>
import MyLikedPlaces from "@/components/profile/MyLikedPlaces.vue";
import MyLikedPosts from "@/components/profile/MyLikedPosts.vue";
import MyPosts from "@/components/profile/MyPosts.vue";
import MyGroups from "@/components/profile/MyGroups.vue";
import MyInfo from "@/components/profile/MyInfo.vue";
import NewButtonComponent from "@/components/profile/NewButtonComponent.vue";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";
import { onBeforeMount, ref, computed } from "vue";
import { useRouter } from "vue-router";
import axios from "axios";

const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);
const router = useRouter();
const menuItems = ref([
  {
    icon: "mdi-heart-outline",
    activeIcon: "mdi-heart",
    text: "내 좋아요 게시글",
    component: MyLikedPosts,
  },
  {
    icon: "mdi-heart-outline",
    activeIcon: "mdi-heart",
    text: "내 좋아요 장소",
    component: MyLikedPlaces,
  },
  { icon: "mdi-heart-outline", activeIcon: "mdi-heart", text: "나의 게시글", component: MyPosts },
  { icon: "mdi-heart-outline", activeIcon: "mdi-heart", text: "나의 그룹", component: MyGroups },
  { icon: "mdi-heart-outline", activeIcon: "mdi-heart", text: "내 정보", component: MyInfo },
  {
    icon: "mdi-heart-outline",
    activeIcon: "mdi-heart",
    text: "나의 쪽지 보기",
    component: NewButtonComponent,
  },
]);

onBeforeMount(() => {
  if (!isLogin.value) {
    alert("로그인이 필요합니다");
    router.push({
      path: "/member/login",
      query: { redirect: router.currentRoute.value.fullPath },
    });
  }
});

const selectedMenu = ref(null);
const toggleMenu = (menuItem) => {
  if (selectedMenu.value === menuItem) {
    selectedMenu.value = null; // 이미 선택된 메뉴를 다시 클릭하면 선택 해제
  } else if (menuItem.text === "나의 쪽지 보기") {
    router.push("/msg/list");
  } else {
    selectedMenu.value = menuItem; // 다른 메뉴를 클릭하면 해당 메뉴를 선택
  }
};

const changeProfilePicture = async () => {
  const input = document.createElement("input");
  input.type = "file";
  input.accept = "image/*";
  input.onchange = async (event) => {
    const file = event.target.files[0];
    if (file) {
      try {
        const formData = new FormData();
        formData.append("file", file);
        formData.append("userId", userinfo.value.userId);

        const response = await axios.post(
          "http://localhost:8080/member/uploadProfileImage",
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        );

        if (response.status === 200) {
          const key = response.data; // Store the key, not the full URL
          userinfo.value.imageUrl = key;
          alert("프로필 사진이 변경되었습니다.");
        } else {
          alert("프로필 사진 변경에 실패했습니다.");
        }
      } catch (error) {
        console.error("Error uploading profile picture:", error);
        alert("프로필 사진 업로드 중 오류가 발생했습니다.");
      }
    }
  };
  input.click();
};

const profileImageUrl = computed(() => {
  if (userinfo.value && userinfo.value.imageUrl) {
    return `https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/${userinfo.value.imageUrl}`;
  }
  return "/profile_icon_ssafy.jpg";
});
</script>

<template>
  <v-container class="profile-page">
    <v-row justify="center" class="mt-5">
      <v-col cols="12" md="8" class="text-center">
        <v-avatar size="120" class="mx-auto profile-avatar">
          <v-img
            class="profile-pic"
            :src="profileImageUrl"
            alt="Profile Picture"
            style="margin: 50px"
          ></v-img>
        </v-avatar>
        <div></div>
        <v-btn small class="mt-2" @click="changeProfilePicture">업로드</v-btn>
        <h3 class="mt-3">{{ userinfo?.userId || "Guest" }}</h3>
        <p>{{ userinfo?.userEmail || "Guest" }}</p>
      </v-col>
    </v-row>
    <v-row justify="center" class="mt-4">
      <v-col cols="12" md="10">
        <v-row>
          <v-col
            cols="12"
            sm="6"
            md="4"
            lg="4"
            v-for="item in menuItems"
            :key="item.text"
            class="d-flex justify-center"
          >
            <v-btn
              :class="{ 'active-menu': selectedMenu === item }"
              class="menu-button mx-2"
              block
              @click="toggleMenu(item)"
              style="height: 80px"
            >
              <v-icon class="mr-2">{{
                selectedMenu === item ? item.activeIcon : item.icon
              }}</v-icon>
              {{ item.text }}
            </v-btn>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-divider style="margin-top: 5%; color: black"></v-divider>
    <v-row>
      <v-col cols="12" style="margin-top: 5%">
        <component :is="selectedMenu?.component" v-if="selectedMenu"></component>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped>
.profile-page {
  padding-top: 50px;
  text-align: center;
  font-family: Inter-Regular;
}

.profile-avatar {
  margin-bottom: 8px;
}

.profile-pic {
  border-radius: 50%;
  object-fit: cover;
  width: 100%;
  height: 100%;
}

.menu-button {
  background-color: #f8f9fa;
  color: #495057;
  height: 100px; /* Increased height for longer buttons */
  font-size: 16px;
  font-weight: 500;
  font-family: Inter-Bold;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  width: 100%; /* Ensure buttons take full width of the column */
}

.menu-button .v-icon {
  font-size: 24px;
}

.menu-button:hover {
  background-color: #e9ecef;
}

.mt-4 {
  margin-top: 40px !important;
}

.v-col {
  padding: 0 8px; /* Add space between the buttons */
}
</style>
