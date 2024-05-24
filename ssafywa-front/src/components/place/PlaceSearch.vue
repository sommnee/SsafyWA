<template>
  <v-container>
    <v-row class="selectChoice">
      <v-col cols="12" md="4">
        <v-select
          v-model="selectedCity"
          :items="cities"
          placeholder="캠퍼스"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
          @change="onCityChange"
        ></v-select>
      </v-col>
      <v-col cols="12" md="4">
        <v-select
          v-model="selectedRegion"
          :items="regions"
          placeholder="지역"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
          :disabled="!selectedCity"
          @change="onRegionChange"
        ></v-select>
      </v-col>
      <v-col cols="11" md="3">
        <v-select
          v-model="selectedCategory"
          :items="categories"
          placeholder="카테고리"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
          :disabled="!selectedRegion"
        ></v-select>
      </v-col>
      <v-col cols="1" md="1" class="d-flex align-center">
        <v-btn icon @click="fetchPlaces" style="height: 50px; background-color: #58d8ff">
          <v-icon style="color: #f3f5f6">mdi-magnify</v-icon>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="searchNum">
      <v-col cols="12">
        <h3>검색 결과 {{ totalPlaces }}개</h3>
      </v-col>
    </v-row>
    <v-row>
      <PlaceCard
        v-for="(place, index) in paginatedPlaces"
        :key="index"
        :place="place"
        @update-like="handleLike"
      />
    </v-row>
    <v-row justify="center">
      <v-col cols="8">
        <v-container class="max-width">
          <v-pagination v-model="page" :length="pages" class="my-4"></v-pagination>
        </v-container>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import PlaceCard from "./PlaceCard.vue";

export default {
  components: {
    PlaceCard,
  },
  data() {
    return {
      selectedCity: null,
      selectedRegion: null,
      selectedCategory: null,
      cities: ["서울", "대전", "광주", "구미", "부울경"],
      regionsData: {
        서울: ["역삼역", "사당역", "서울역", "홍대역", "왕십리역", "잠실역"],
        대전: ["삼성화재유성연수원", "유성온천역", "노은역", "대전시청역", "중앙로역"],
        광주: ["삼성전자광주사업장", "상무역", "광주역", "광주서구청", "광주동구청"],
        구미: [
          "삼성전자구미사업장",
          "구미역",
          "구미종합터미널",
          "폴리텍대학구미캠퍼스",
          "상모초등학교",
        ],
        부울경: ["삼성전기부산사업장", "하단역", "스타필드시티명지", "녹산중학교"],
      },
      categories: ["카페", "스터디카페", "음식점", "헬스", "은행"],
      places: [],
      page: 1,
      itemsPerPage: 12,
      selection: [],
    };
  },
  computed: {
    regions() {
      return this.selectedCity ? this.regionsData[this.selectedCity] : [];
    },
    filteredPlaces() {
      return this.places;
    },
    totalPlaces() {
      return this.filteredPlaces.length;
    },
    pages() {
      return Math.ceil(this.filteredPlaces.length / this.itemsPerPage);
    },
    paginatedPlaces() {
      const start = (this.page - 1) * this.itemsPerPage;
      const end = this.page * this.itemsPerPage;
      return this.filteredPlaces.slice(start, end);
    },
  },
  methods: {
    onCityChange() {
      this.selectedRegion = null;
      this.selectedCategory = null;
      this.page = 1;
    },
    onRegionChange() {
      this.selectedCategory = null;
      this.page = 1;
    },
    fetchPlaces() {
      if (this.selectedRegion && this.selectedCategory) {
        console.log("Fetching places with:", this.selectedRegion, this.selectedCategory);
        axios
          .get(`http://localhost:8080/place/search`, {
            params: {
              region: this.selectedRegion,
              category: this.selectedCategory,
            },
          })
          .then((response) => {
            console.log("Response:", response.data);
            if (Array.isArray(response.data)) {
              this.places = response.data.map((place) => ({
                ...place,
                name: place.placeName, // Adjust as needed to match the expected structure
                address: place.roadAddressName, // Adjust as needed to match the expected structure
                image: "placeholder.jpg", // Replace with actual image URL or a placeholder
              }));
            } else {
              console.error("Unexpected response data format:", response.data);
            }
          })
          .catch((error) => {
            console.error("Error fetching places:", error);
          });
      } else {
        console.log("Please select both region and category.");
      }
    },
    handleLike(place, isLiked) {
      console.log(`Place: ${place.name}, Liked: ${isLiked}`);
    },
  },
};
</script>

<style scoped>
@import "@/assets/fonts.css";

.selectChoice {
  margin: 50px 0px;
}

.searchNum {
  margin-top: 40px;
  margin-bottom: 20px;
}

.custom-select {
  font-family: Inter-Regular;
}

.v-btn {
  min-width: 0;
}
</style>
