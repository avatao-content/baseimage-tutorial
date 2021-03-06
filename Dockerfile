FROM avatao/debian:buster

RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        supervisor

RUN pip3 install \
        pyzmq==19.0.2 \
        tornado==6.0.4 \
        pyyaml \
        git+https://github.com/avatao-content/tfwsdk-python.git@0e9d9953f564f78d9bdce0cf70791053b4ede125
        
COPY tutorial /home/user/tutorial
COPY etc /etc

RUN chown -R user:user /home/user

ONBUILD COPY solvable/tutorial /home/user/tutorial
ONBUILD RUN python3 /home/user/tutorial/create_app_from_yml.py

CMD exec supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
