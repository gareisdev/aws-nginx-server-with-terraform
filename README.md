<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (5.26.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) (resource)
- [aws_instance.nginx-server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) (resource)
- [aws_internet_gateway.internet-gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) (resource)
- [aws_network_interface.network-interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) (resource)
- [aws_route_table.route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) (resource)
- [aws_route_table_association.association-1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) (resource)
- [aws_security_group.security-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [aws_subnet.subnet-1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (resource)
- [aws_vpc.my-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) (resource)
- [aws_ami.ubuntu-ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type)

Description: n/a

Type: `string`

Default: `"t2.micro"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->