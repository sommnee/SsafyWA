import { localAxios } from "@/util/http-commons";
const local = localAxios();
function getMyPost(userId, success, fail){
    local.get(`/profile/post/${userId}`).then(success).catch(fail);
}
function getLikedPost(userId, success, fail){
    local.get(`/profile/like/post/${userId}`).then(success).catch(fail);
}
export{
    getMyPost,
    getLikedPost
}