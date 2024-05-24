import { defineStore } from "pinia";
import {ref} from "vue";
export const useMenuStore = defineStore("menuStore", () => {
    const menuList = ref([
        {name : "로그인", show : true, routeName : "login"},
        {name : "그룹만들기", show : true, routeName : "group"},
        {name : "프로필", show : true, routeName : "profile"},
        {name : "검색", show : true, routeName : "place-search"},
        {name : "로그아웃", show : false, routeName : "logout"},
        {name : "게시판", show : true, routeName : "board"},
        {name : "이름", show : false, routeName : "userName"},
    ])

    const changeMenuState = () => {
        menuList.value[0].show = !menuList.value[0].show
        menuList.value[4].show = !menuList.value[4].show
        menuList.value[6].show = !menuList.value[6].show
    }
    return{
        menuList,
        changeMenuState
    }
})