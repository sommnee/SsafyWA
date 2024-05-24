import { localAxios } from "@/util/http-commons";
const local = localAxios();
async function getUnReadMsgCount(userId, success, fail){
    await local.get(`/message/unread/count/${userId}`).then(success).catch(fail);
}
async function getUserReceivedMsg(userId, success, fail){
    await local.get(`/message/list/received/${userId}`).then(success).catch(fail);
}
async function getUnReadMsg(userId, success, fail){
    await local.get(`/message/list/unread/${userId}`).then(success).catch(fail);
}
async function getUserSendMsg(userId, success, fail){
    await local.get(`/message/list/send/${userId}`).then(success).catch(fail);
}
async function makeUnreadToRead(id, success, fail){
    await local.put(`/message/read/${id}`).then(success).catch(fail);
}
async function getMessage(id, success, fail){
    await local.get(`/message/${id}`).then(success).catch(fail);
}
export{
    getUnReadMsgCount,
    getUnReadMsg,
    getUserSendMsg,
    getUserReceivedMsg,
    makeUnreadToRead,
    getMessage
}