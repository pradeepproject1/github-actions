# GitHub Actions - Python EC2 Deployment

## Workflow Overview
| Branch | Environment | Approval |
|--------|-------------|----------|
| dev    | dev         | Auto     |
| qa1    | qa1         | Auto     |
| qa2    | qa2         | Auto     |
| stage  | stage       | Manual   |

---

## One-Time GitHub Setup

### 1. Create Branches
```bash
git checkout -b dev && git push origin dev
git checkout -b qa1 && git push origin qa1
git checkout -b qa2 && git push origin qa2
git checkout -b stage && git push origin stage
```

### 2. Add GitHub Secrets
Go to: `GitHub Repo → Settings → Secrets and Variables → Actions`

| Secret                | Value                          |
|-----------------------|--------------------------------|
| AWS_ACCESS_KEY_ID     | Your AWS access key            |
| AWS_SECRET_ACCESS_KEY | Your AWS secret key            |
| AWS_REGION            | us-east-1                      |
| EC2_HOST              | Your EC2 public IP             |
| EC2_SSH_KEY           | Contents of your .pem key file |

### 3. Setup Stage Approval
```
GitHub Repo → Settings → Environments → stage
→ Check "Required reviewers"
→ Add your GitHub username
→ Save
```

---

## EC2 One-Time Setup
```bash
# SSH into EC2 and run
mkdir -p /home/ec2-user/app/scripts
mkdir -p /home/ec2-user/app/environments
```

---

## How to Deploy
- Push to `dev`   → auto deploys to dev EC2
- Push to `qa1`   → auto deploys to qa1 EC2
- Push to `qa2`   → auto deploys to qa2 EC2
- Push to `stage` → waits for your approval in GitHub Actions tab

---

## CircleCI vs GitHub Actions Mapping
| CircleCI          | GitHub Actions           |
|-------------------|--------------------------|
| context           | secrets                  |
| approval job      | environment + reviewer   |
| filters: branches | on: push: branches       |
| orbs              | uses (marketplace)       |
| executors         | runs-on                  |
