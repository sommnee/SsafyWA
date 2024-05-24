<template>
  <v-col cols="12" md="6" lg="4">
    <v-card class="mx-auto custom-card" @click="goToPlaceDetail">
      <StaticMap
        :x="place.x"
        :y="place.y"
        :markers="[{ x: place.x, y: place.y }]"
        class="card-map"
      />
      <v-card-title>{{ place.placeName }}</v-card-title>
      <v-card-subtitle>{{ place.roadAddressName }}</v-card-subtitle>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn icon @click.stop="toggleLike" class="heart-btn">
          <v-icon :color="isLiked ? 'blue' : 'black'">{{
            isLiked ? "mdi-heart" : "mdi-heart-outline"
          }}</v-icon>
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-col>
</template>

<script>
import StaticMap from "./StaticMap.vue";
import { storeToRefs } from "pinia";
import { useMemberStore } from "@/stores/member";
import axios from "axios";

export default {
  props: {
    place: {
      type: Object,
      required: true,
    },
  },
  components: {
    StaticMap,
  },
  data() {
    return {
      isLiked: false,
    };
  },
  methods: {
    async toggleLike(event) {
      if (!this.isLogin) {
        alert("로그인 후 이용하세요");
        return;
      }

      const action = this.isLiked ? "unlike" : "like";
      try {
        await axios.post(`http://localhost:8080/place/${this.place.placeId}/${action}`, null, {
          params: { userId: this.userinfo.userId },
        });
        this.place.likeCount += this.isLiked ? -1 : 1;
        this.isLiked = !this.isLiked;
      } catch (error) {
        console.error(`Error ${this.isLiked ? "unliking" : "liking"} place:`, error);
      }
    },
    async checkIfLiked() {
      if (!this.isLogin) return;

      try {
        const response = await axios.get(
          `http://localhost:8080/place/${this.place.placeId}/liked`,
          {
            params: { userId: this.userinfo.userId },
          }
        );
        this.isLiked = response.data;
      } catch (error) {
        console.error("Error checking if user liked the place:", error);
      }
    },
    goToPlaceDetail() {
      this.$router.push({ name: "place-specific", params: { id: this.place.placeId } });
    },
  },
  async mounted() {
    await this.checkIfLiked();
  },
  setup() {
    const memberStore = useMemberStore();
    const { userinfo, isLogin } = storeToRefs(memberStore);

    return {
      userinfo,
      isLogin,
    };
  },
};
</script>

<style scoped>
.custom-card {
  margin-bottom: 20px;
  border-radius: 15px;
  overflow: hidden;
  cursor: pointer;
}
.card-map {
  height: 300px;
  width: 100%;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
}
.heart-btn {
  margin-top: -10px;
}
</style>
