FROM centos


RUN yum install wget -y


RUN yum install git -y


RUN yum install sudo -y


RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo


RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key


RUN yum install java-11-openjdk.x86_64 -y


RUN yum install jenkins -y


RUN yum install net-tools -y


RUN yum install python36 -y


RUN yum install initscripts -y


RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


USER jenkins


ENV USER jenkins


RUN sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl



RUN sudo chmod +x ./kubectl


RUN sudo mv ./kubectl /usr/local/bin/kubectl


RUN sudo mkdir /root/.kube


COPY  ca.crt /root/.kube/


COPY  client.crt /root/.kube/


COPY  client.key /root/.kube/


COPY  config /root/.kube/

CMD ["java" ,"-jar", "/usr/lib/jenkins/jenkins.war"]


EXPOSE 8080
