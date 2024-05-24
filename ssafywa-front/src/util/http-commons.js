import axios from "axios";

const API_URL = import.meta.env.VITE_API_URL;

function localAxios(){
    console.log(API_URL)
    const instance = axios.create({
        baseURL : "http://localhost:8080",
    });
    instance.defaults.headers.common["Authorization"] = "";
    instance.defaults.headers.post["Content-Type"] = "application/json";
    instance.defaults.headers.put["Content-Type"] = "application/json";
    return instance;
}

export {localAxios};