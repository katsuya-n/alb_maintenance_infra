# alb_maintenance_infra
alb maintenance infra repository

tfstate用のs3バケットを作成しておく
EC2にアクセスできるようにキーペアを作成しておく

```bash
$ cd app/
$ touch backend.conf
$ touch terraform.tfvars
```

以下をbackend.confに記載

```
bucket = "[バケット名]"
key = "[キー名]"
region = "[リージョン名]"
```

以下をterraform.tfvarsに記載

```
allow_cidr_block="[EC2とALBにアクセスしたいIPアドレス]"
key_name="[作成したキーペアのID]"
```

```bash
$ terraform init -backend-config=backend.conf
$ terraform plan
$ terraform apply
```

