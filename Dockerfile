FROM atlas/analysisbase:21.2.27

RUN source ~/release_setup.sh && pip install jupyter metakernel zmq --user
RUN echo 'export PATH=$PATH:$HOME/.local/bin' >> /home/atlas/setup.sh

USER root
RUN ln -s /usr/lib64/python2.6/lib-dynload/_sqlite3.so /usr/AnalysisBaseExternals/21.2.27/InstallArea/x86_64-slc6-gcc62-opt/lib/python2.7/lib-dynload/_sqlite3.so
ADD entrypoint.sh /entrypoint.sh
RUN chown atlas /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN usermod -u 1000 atlas
RUN find /home -user 500 -type f -exec chown -h atlas '{}' \;


USER atlas
RUN source /home/atlas/release_setup.sh && cp -r $ROOTSYS/etc/notebook/kernels/root ~/.local/share/jupyter/kernels

ENTRYPOINT ["/entrypoint.sh"]
