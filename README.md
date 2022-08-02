# alb_maintenance_infra
alb maintenance infra repository

tfstate用のs3バケットを作成しておく

```bash
$ cd app/
$ touch backend.conf
```

以下をbackend.tfstateに記載

```
bucket = "[バケット名]"
key = "[キー名]"
region = "[リージョン名]"
```

```bash
$ terraform init -backend-config=backend.conf
$ terraform plan
$ terraform apply
```

