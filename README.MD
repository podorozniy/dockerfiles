Repo for Docker image building and pishing to DockerHub  

For build and push image you have to:  
1/ create branch in repo  
2/ create Dockerfile and push it to its own branch  
3/ Add Jenkinsfile from previous branch and edit vars  
```
app = docker.build("playwing/php")    
```
```          
app.push("vod74-alpine")     
```
4/ push button "Scan Multibranch Pipeline Now" in 
```
https://jenkins.dev-integrations.com/view/DevOPs/job/dockerhub-images-pipeline/
```