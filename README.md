# GitHub Actions - Python Docker ECR Deployment

## Flow
```
Push Code → GitHub Actions → Build Docker Image → Push to ECR
```

## Workflow Overview
| Branch | Environment | Approval |
|--------|-------------|----------|
| dev    | dev         | Auto     |
| qa1    | qa1         | Auto     |
| qa2    | qa2         | Auto     |
| stage  | stage       | Manual   |

---

## One-Time AWS Setup

### 1. Create ECR Repository
```bash
aws ecr create-repository --repository-name my-python-app --region us-east-1
```

### 2. IAM User Permissions
Attach to your IAM user:
- `AmazonEC2ContainerRegistryFullAccess`

---

## GitHub Setup

### 1. Create Branches
```bash
git checkout -b dev && git push origin dev
git checkout -b qa1 && git push origin qa1
git checkout -b qa2 && git push origin qa2
git checkout -b stage && git push origin stage
```

### 2. Add GitHub Secrets
`GitHub Repo → Settings → Secrets and Variables → Actions`

| Secret                | Value               |
|-----------------------|---------------------|
| AWS_ACCESS_KEY_ID     | Your AWS access key |
| AWS_SECRET_ACCESS_KEY | Your AWS secret key |
| AWS_REGION            | us-east-1           |

### 3. Stage Approval Setup
```
GitHub Repo → Settings → Environments → stage
→ Check "Required reviewers"
→ Add your GitHub username
→ Save
```

---

## How to Deploy
- Push to `dev`   → builds image tagged `dev-<sha>`, pushes to ECR
- Push to `qa1`   → builds image tagged `qa1-<sha>`, pushes to ECR
- Push to `qa2`   → builds image tagged `qa2-<sha>`, pushes to ECR
- Push to `stage` → waits for approval → builds image tagged `stage-<sha>` → pushes to ECR
