# Getting Started

To get started with the Chain of Innovation platform, follow these steps:

1. **Clone the Repository**: 
   ```bash
   1 git clone https://github.com/Revolutination/chain-of-innovation.git
   ```

2. Install Dependencies:

   ```bash
   1 npm install
   ```
   
3. Run the Application:

   ```bash
   1 npm start
   ```
   
4. Access the UI: Open your web browser and navigate to http://localhost:3000.

You are now ready to explore the Chain of Innovation platform!

# Example Dockerfile

```dockerfile
1 FROM node:14
2 
3 WORKDIR /app
4 
5 COPY package*.json ./
6 
7 RUN npm install
8 
9 COPY . .
10 
11 RUN npm run build
12 
13 EXPOSE 3000
14 
15 CMD ["npm", "start"]
```
