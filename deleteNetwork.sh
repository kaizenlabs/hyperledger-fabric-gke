if [ $# -eq 0 ]
  then
    echo "Please provide your GCP zone as a first argument. See docs for an example."
    exit
fi


KUBECONFIG_FOLDER=${PWD}/configFiles

kubectl delete -f ${KUBECONFIG_FOLDER}/chaincode_instantiate.yaml
kubectl delete -f ${KUBECONFIG_FOLDER}/chaincode_install.yaml

kubectl delete -f ${KUBECONFIG_FOLDER}/join_channel.yaml
kubectl delete -f ${KUBECONFIG_FOLDER}/create_channel.yaml

kubectl delete --ignore-not-found=true -f ${KUBECONFIG_FOLDER}/docker.yaml

kubectl delete -f ${KUBECONFIG_FOLDER}/peersDeployment.yaml
kubectl delete -f ${KUBECONFIG_FOLDER}/blockchain-services.yaml

kubectl delete -f ${KUBECONFIG_FOLDER}/generateArtifactsJob.yaml
kubectl delete -f ${KUBECONFIG_FOLDER}/copyArtifactsJob.yaml

kubectl delete -f ${KUBECONFIG_FOLDER}/createVolume.yaml
kubectl delete --ignore-not-found=true -f ${KUBECONFIG_FOLDER}/docker-volume.yaml

kubectl delete -f ${KUBECONFIG_FOLDER}/nfs-server-deployment.yaml
kubectl delete -f ${KUBECONFIG_FOLDER}/nfs-clusterip-service.yaml

gcloud compute disks delete nfs-disk -q --zone=$1

sleep 15

echo -e "\npv:" 
kubectl get pv
echo -e "\npvc:"
kubectl get pvc
echo -e "\njobs:"
kubectl get jobs 
echo -e "\ndeployments:"
kubectl get deployments
echo -e "\nservices:"
kubectl get services
echo -e "\npods:"
kubectl get pods
echo -e "\nnfs-disk:"
gcloud compute disks list | grep nfs-disk 

echo -e "\nNetwork Deleted!!\n"
