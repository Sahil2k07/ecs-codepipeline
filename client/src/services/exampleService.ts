import type { AxiosInstance } from "axios";
import axiosInstance from "./axios";

class exampleService {
  private axios: AxiosInstance;

  constructor(a: AxiosInstance) {
    this.axios = a;
  }

  async testExampleAPI() {
    return await this.axios.get("/api/example");
  }
}

export default new exampleService(axiosInstance);
