CfhighlanderTemplate do

  Name 'infra'

  ## Creates resources for the Networking, HostedZone, Nat Gateway
  ## Exports the VPC id
  Component template: 'vpc', name: 'vpc' do
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name: 'StackOctet', value: '0'
    parameter name: 'MaxNatGateways', value: '1'
    parameter name: 'SingleNatGateway', value: true
  end

  ## Creates a asg of 1 resource and a securitygroup to contoll network access
  Component template: 'bastion', name: 'bastion' do
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name: 'KeyName', value: 'cfhighalnderworkshop'
    parameter name: 'InstanceType', value: 't2.micro'
  end

  ## Creates the ecs cluster, asg for the ecs hosts and security group
  ## Exports the ecs cluster name and arn
  Component template: 'ecs', name: 'ecs' do
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name: 'KeyName', value: 'cfhighalnderworkshop'
    parameter name: 'InstanceType', value: 't2.small'
    parameter name: 'AsgMin', value: '1'
    parameter name: 'AsgMax', value: '1'
  end

  ## Creates a application loadbalancer with a http listener and default target group as well as a securtiy group
  ## Config for this component is in loadbalancer.config.yaml
  ## Exports the listener arn
  Component template: 'loadbalancer', name: 'loadbalancer' do
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
  end

end
