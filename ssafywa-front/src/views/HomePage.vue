<script setup>
import { getHotPost } from '@/api/board';
import { getAllGroups } from '@/api/group';
import GroupDetail from '@/components/group/GroupDetail.vue';
import {onMounted, ref} from "vue";
import { useRouter } from 'vue-router';
// import { useMemberStore } from '@/stores/member';
// import { storeToRefs } from 'pinia';
// import { onMounted } from 'vue';
// const memberStore = useMemberStore();
const router = useRouter();
const selectedGroup = ref(null);
const isModalOpen = ref(false);
const openGroupModal = (group) => {
  selectedGroup.value = group;
  isModalOpen.value = true;
};
const extractTextThumbnail = (content) => {
  // DOMParser를 사용하여 HTML 파싱
  const parser = new DOMParser();
  const doc = parser.parseFromString(content, 'text/html');
  const textContent = doc.body.textContent || "";
  // 첫 100자 추출
  return textContent.length > 30 ? textContent.substring(0, 60) + '...' : textContent;
};
const hotPosts = ref([]);
const groups = ref([]);
const fetchHotList = () => {
  getHotPost(
    ({ data }) => {
      console.log(data);
      hotPosts.value = data.slice(0, 3).map(hotpost => {
        return {
          ...hotpost,
          thumbnail: extractTextThumbnail(hotpost.content)
        };
      });
      // 처음 3개 요소를 가져와서 hotPosts에 저장
    },
    (error) => {
      console.log(error);
    }
  );
}
const getGroup = () => {
  getAllGroups(
    ({ data }) => {
      groups.value = data.slice(0, 3).map(group => {
        return {
          ...group
        };
      });
      console.log(groups.value);
      // 처음 3개 요소를 가져와서 hotPosts에 저장
    },
    (error) => {
      console.log(error);
    }
  );
}
const goHotDetail = (id) => {
  router.push(`/board/${id}`)
}
const goHotGroupDetail = (id) => {
  router.push(`/group/${id}`)
}
const gochat = () => {
  router.push(`/chat`)
}
onMounted(() => {
  fetchHotList();
  getGroup();
})
</script>

<template>
  <div class="content">
    <v-carousel :show-arrows="false">
      <v-carousel-item src="/public/Slide2.JPG" cover></v-carousel-item>
      <v-carousel-item src="/public/Slide1.JPG" cover></v-carousel-item>
      <v-carousel-item src="/public/Slide3.JPG" cover></v-carousel-item>
    </v-carousel>
    <!-- 추가 콘텐츠 -->
    <div class="additional-content" style="background-color: #F3F5F6;">
      <h2 style="margin-left: 11%; margin-top: 2%;"><v-icon size="x-large" color="red">mdi-fire</v-icon><span style="color: red;">HOT</span> 게시글</h2>
      <v-container style="margin-top: 1%;">
        <v-row>
          <v-col cols="12" sm="6" md="4" v-for="item in hotPosts" :key="item.id">
            <v-card
              class="mx-auto d-flex flex-column post-card"
              max-width="400"
              min-height="280px"
              prepend-icon="mdi-fire"
              :title=item.title
              @click="goHotDetail(item.id)"
            >
              <template v-slot:prepend>
                <v-icon size="x-large" color="red"></v-icon>
              </template>
            
              <v-card-text class="text-h5 py-2">
                {{ item.thumbnail }}
              </v-card-text>

              <v-spacer></v-spacer>
            
              <v-card-actions>
                <v-list-item class="w-100">
                  <template v-slot:prepend>
                    <v-avatar
                      color="grey-darken-3"
                      image="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
                    ></v-avatar>
                  </template>
                
                  <v-list-item-title>{{ item.writer }}</v-list-item-title>
                
                
                  <template v-slot:append>
                    <div class="justify-self-end">
                      <v-icon class="me-1" icon="mdi-heart"></v-icon>
                      <span class="subheading me-2">{{ item.commentCount }}</span>
                      <span class="me-1"></span>
                      <v-icon class="me-1" icon="mdi-comment"></v-icon>
                      <span class="subheading">{{ item.commentCount }}</span>
                      <span class="me-1"></span>
                      <v-icon class="me-1" icon="mdi-eye"></v-icon>
                      <span class="subheading">{{ item.readCount }}</span>
                    </div>
                  </template>
                </v-list-item>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
      <h2 style="margin-left: 11%; margin-top: 2%;"><v-icon size="x-large" color="blue">mdi-account-group</v-icon><span > 모집중인</span> 그룹</h2>
      <v-container style="margin-top: 1%;">
        <v-row>
          <v-col cols="12" sm="6" md="4" v-for="item in groups" :key="item">
            <v-card
              class="mx-auto d-flex flex-column post-card"
              max-width="400"
              min-height="280px"
              prepend-icon="mdi-account-group"
              :title=item.groupName
              @click="openGroupModal(item)"
            >
              <template v-slot:prepend>
                <v-icon size="x-large" color="blue"></v-icon>
              </template>
            
              <v-card-text class="text-h5 py-2">
                {{ item.content }}
              </v-card-text>

              <v-spacer></v-spacer>
            
              <v-card-actions>
                <v-list-item class="w-100">
                  <template v-slot:prepend>
                    <v-avatar
                      color="grey-darken-3"
                      image="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
                    ></v-avatar>
                  </template>
                
                  <v-list-item-title>{{ item.groupOwner }}</v-list-item-title>
                
                
                  <template v-slot:append>
                    <div class="justify-self-end">
                      <v-icon class="me-1" icon="mdi-account-multiple"></v-icon>
                      <span class="subheading me-2">{{ item.recruitMaxNumber }}</span>
                      <span class="me-1"></span>
                      <v-icon class="me-1" icon="mdi-label-outline"></v-icon>
                      <span class="subheading">{{ item.type }}</span>
                      <span class="me-1"></span>
                    </div>
                  </template>
                </v-list-item>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
      <v-dialog v-model="isModalOpen" persistent max-width="600px">
        <template v-slot:activator="{ on, attrs }"></template>
        <GroupDetail :group="selectedGroup" @close="isModalOpen = false" />
      </v-dialog>
    </div>
  </div>
</template>

<style scoped>
.content {
  padding: 0;
  margin: 0;
  height: 100vh;
}
.additional-content {
  padding: 16px;
}
.post-card {
    /* padding: 16px;
    margin-bottom: 16px; */
    color: black;
    border: 1;
    border-radius: 5px;
    border-color: blue;
  }
  .post-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* hover 시 그림자 효과 */
  transform: translateY(-3px); /* hover 시 살짝 위로 이동 */
  cursor: pointer; /* hover 시 커서 변경 */
  }
</style>
