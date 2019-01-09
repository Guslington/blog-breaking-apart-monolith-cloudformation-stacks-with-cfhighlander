CfhighlanderComponent do
  Name 'api'

  Parameters do
    ComponentParam 'ApiTag'
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true, allowedValues: ['development','production']
    ComponentParam 'DesiredCount', 1
    ComponentParam 'MinimumHealthyPercent', 0
    ComponentParam 'MaximumPercent', 100
  end

  Component template: 'ecs-service', name: 'api-service', render: Inline do
    parameter name: 'ApiTag', value: Ref('ApiTag')
    parameter name: 'EcsCluster', value: FnImportValue(FnSub("${EnvironmentName}-ecs-EcsCluster"))
    parameter name: 'Listener', value: FnImportValue(FnSub("${EnvironmentName}-loadbalancer-httpListener"))
    parameter name: 'VPCId', value: FnImportValue(FnSub("${EnvironmentName}-vpc-VPCId"))
    parameter name: 'DnsDomain', value: 'workshop.cfhighlander.info'
  end

end
