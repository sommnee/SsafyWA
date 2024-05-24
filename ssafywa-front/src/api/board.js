import { localAxios } from "@/util/http-commons";
const local = localAxios();
function listArticle(success, fail){
    local.get(`/board/list`).then(success).catch(fail);
}

function detailArticle(param, success, fail){
    local.get(`/board/${param}`).then(success).catch(fail);
}
function registArticle(article, success, fail){
    local.post(`/board/write`, JSON.stringify(article)).then(success).catch(fail)
}
function uploadImage(img, success, fail){
    
    local.post(`/image/upload`, img,{
        headers: {
            'Content-Type': 'multipart/form-data'
          }
    }
    ).then(success).catch(fail)
}

function printImage(filename, success, fail) {
    local.get(`image/print?filename=${filename}`,{
        headers: {
            'Content-Type': 'text/plain'
          },
    }).then(success).catch(fail);
  }
function userLikedPost(postId, userId, success, fail) {
    local.get(`/board/liked/${postId}`, { params: { userId } }).then(success).catch(fail);
}
function likePost(postId, userId, success, fail) {
    local.post(`/board/like/add`, { boardId: postId, userId: userId }).then(success).catch(fail);
}

function unlikePost(postId, userId, success, fail) {
    local.post(`/board/like/delete`, { boardId: postId, userId: userId }).then(success).catch(fail);
}
function postComment(comment, success, fail) {
    local.post(`/comment/post`, comment).then(success).catch(fail);
}
function getCommentList(boardId, success, fail){
    local.get(`/comment/list/${boardId}`).then(success).catch(fail);
}
function getCategoryList(category, campus, success, fail){
    local.get(`/board/list/${category}`,{params : {campus : campus}}).then(success).catch(fail);
}
function getSortedList(category,sort, success, fail){
    local.get(`/board/list/sort/${category}`, {params : {sorted : sort}}).then(success).catch(fail);
}
function updateReadCount(boardId, success, fail){
    local.put(`/board/add/views/${boardId}`).then(success).catch(fail);
}
function getHotPost(success, fail){
    local.get(`/board/list/hot`).then(success).catch(fail);
}
function getRecentHot(success, fail){
    local.get(`/board/list/recent`).then(success).catch(fail);
}
export {
    listArticle,
    detailArticle,
    registArticle,
    uploadImage,
    printImage,
    userLikedPost,
    likePost,
    unlikePost,
    postComment,
    getCommentList,
    getCategoryList,
    getSortedList,
    updateReadCount,
    getHotPost,
    getRecentHot
}