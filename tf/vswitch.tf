# 变量定义：便于在 ROS 控制台或配置文件中动态传入参数
variable "region" {
  type        = string
  description = "地域 ID，默认为杭州"
  default     = "cn-hangzhou"
}

variable "vpc_id" {
  type        = string
  description = "现有专有网络 VPC 的 ID"
  default     = "vpc-bp1q4gw11c0avni4or14v"
}

variable "zone_id" {
  type        = string
  description = "可用区 ID"
  default     = "cn-hangzhou-h"
}

variable "vswitch_cidr" {
  type        = string
  description = "交换机的 CIDR 块（必须在 VPC 的网段范围内）"
  default     = "172.16.1.0/24"
}

variable "vswitch_name" {
  type        = string
  description = "交换机的名称"
  default     = "tf-vswitch-ros-demo"
}

# Provider 配置：ROS 会自动处理身份认证，无需硬编码 AccessKey
provider "alicloud" {
  region = var.region
}

# 资源创建：创建阿里云 VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id            = var.vpc_id
  cidr_block        = var.vswitch_cidr
  availability_zone = var.zone_id
  vswitch_name      = var.vswitch_name
}

# 输出结果：部署成功后返回 VSwitch ID
output "vswitch_id" {
  value = alicloud_vswitch.vswitch.id
}
