### 디렉토리 구조
```
terraform/
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── env/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
└── provider.tf
```

### 환경변수 변경 (env/dev/terraform.tfvars)
```
vpc_cidr             = "172.16.0.0/16"
public_subnet_cidrs  = ["172.16.1.0/24", "172.16.2.0/24"]
private_subnet_cidrs = ["172.16.10.0/24", "172.16.11.0/24"]
azs                  = ["ap-northeast-2a", "ap-northeast-2c"]
```

### 실행 방법 (사전에 aws configure 설정)
```
cd terraform/envs/dev

terraform init       # 모듈, provider 초기화
terraform plan       # 어떤 리소스가 생성되는지 확인
terraform apply      # 실제로 리소스 생성
```


### 아키텍처 구조
<img src="./architecture01.png">

