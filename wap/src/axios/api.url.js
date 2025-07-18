const ENV = process.env.NODE_ENV;

export default {
  DOMAIN: 'https://api.hxcszy888.com/',
  baseURL: ENV == 'development'?'https://api.hxcszy888.com/':'https://api.hxcszy888.com/',
  // baseURL: 'http://localhost:8070',
  // 其他服务器备用
  // baseURL: 'http://143.92.58.242:8091/',
  util: {
    image: '/util/image.html'
  }
}
