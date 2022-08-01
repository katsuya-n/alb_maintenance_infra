# alb_maintenance_infra
alb maintenance infra repository

tfstate用のs3バケットを作成しておく

```bash
$ cd app/
$ touch backend.tfstate
```

以下をbackend.tfstateに記載

```
bucket = "[バケット名]"
key = "[キー名]"
region = "[リージョン名]"
```

```bash
$ terraform init -backend-config=backend.tfstate
$ terraform plan
$ terraform apply
```

