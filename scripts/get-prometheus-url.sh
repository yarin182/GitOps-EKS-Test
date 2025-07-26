#!/bin/bash

echo "Getting Istio IngressGateway ALB URL..."
echo "======================================"

# Get the external hostname of the Istio IngressGateway ALB
EXTERNAL_HOSTNAME=$(kubectl get svc istio-ingressgateway -n istio-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$EXTERNAL_HOSTNAME" ]; then
    echo "❌ External hostname not found. The ALB might still be provisioning..."
    echo "Check the service status:"
    kubectl get svc istio-ingressgateway -n istio-ingress
    exit 1
fi

echo "✅ Istio IngressGateway ALB URL: $EXTERNAL_HOSTNAME"
echo ""
echo "🌐 Prometheus UI URLs:"
echo "   HTTP:  http://$EXTERNAL_HOSTNAME/prometheus"
echo "   HTTPS: https://$EXTERNAL_HOSTNAME/prometheus (if TLS is configured)"
echo ""
echo "📋 To check if the service is ready:"
echo "   kubectl get svc istio-ingressgateway -n istio-ingress"
echo ""
echo "🔍 To check Gateway and VirtualService status:"
echo "   kubectl get gateway -n monitor"
echo "   kubectl get virtualservice -n monitor" 