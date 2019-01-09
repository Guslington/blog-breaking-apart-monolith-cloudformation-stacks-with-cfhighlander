CfhighlanderComponent do
  Name 'web'

  Parameters do
    ComponentParam 'WebTag'
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true, allowedValues: ['development','production']
    ComponentParam 'DesiredCount', 1
    ComponentParam 'MinimumHealthyPercent', 0
    ComponentParam 'MaximumPercent', 100
  end

  Component template: 'ecs-service', name: 'web-service', render: Inline do
    parameter name: 'WebTag', value: Ref('WebTag')
    parameter name: 'EcsCluster', value: FnImportValue(FnSub("${EnvironmentName}-ecs-EcsCluster"))
    parameter name: 'Listener', value: FnImportValue(FnSub("${EnvironmentName}-loadbalancer-httpListener"))
    parameter name: 'VPCId', value: FnImportValue(FnSub("${EnvironmentName}-vpc-VPCId"))
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
  end

end
