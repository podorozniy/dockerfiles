node {    
      def app     
      stage('Clone repository') {               
             
            checkout scm    
      }     
      stage('Build image') {         
       
            app = docker.build("playwing/php")    
       }      
       stage('Push image') {
                                                  docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {            
       app.push("${env.BUILD_NUMBER}")            
       app.push("pw-alpine")        
              }    
           }
        }