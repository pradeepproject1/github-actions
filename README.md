# GitHub Actions - CircleCI Migration (Python + Docker + ECR)

## Migration: CircleCI → GitHub Actions

| CircleCI File | GitHub Actions File |
|---|---|
| deploy.yaml | .github/workflows/deploy.yml |
| qa.yaml | .github/workflows/qa.yml |
| qa1.yaml | .github/workflows/qa1.yml |
| stage.yaml | .github/workflows/stage.yml |
| pre-prod.yaml | .github/workflows/pre-prod.yml |
| prod.yaml | .github/workflows/prod.yml |

---

## Pipeline Flow
```
dev → qa → qa1 → stage → pre-prod → prod
Auto  Auto  Auto   Auto    Approval  Approval
```

## Workflow Overview
| Branch   | Environment | Approval | Image Tag |
|----------|-------------|----------|-----------|
| dev      | dev         | Auto     | dev-<sha> |
| qa       | qa          | Auto     | qa-<sha> |
| qa1      | qa1         | Auto     | qa1-<sha> |
| stage    | stage       | Auto     | stage-<sha> |
| pre-prod | pre-prod    | Manual   | pre-prod-<sha> |
| prod     | prod        | Manual   | prod-<sha> |

---

## One-Time GitHub Setup

### 1. Create Branches
```bash
git checkout -b dev && git push origin dev
git checkout -b qa && git push origin qa
git checkout -b qa1 && git push origin qa1
git checkout -b stage && git push origin stage
git checkout -b pre-prod && git push origin pre-prod
git checkout -b prod && git push origin prod
```

### 2. Create Environments
```
GitHub Repo → Settings → Environments → New environment
Create: dev, qa, qa1, stage, pre-prod, prod

For pre-prod and prod:
→ Check "Required reviewers"
→ Add your GitHub username
→ Save
```

### 3. Add GitHub Secrets
```
GitHub Repo → Settings → Secrets and Variables → Actions

AWS_ACCESS_KEY_ID     → Your AWS access key
AWS_SECRET_ACCESS_KEY → Your AWS secret key
AWS_REGION            → us-east-1
```

---

## How to Deploy
```bash
# Auto deployments
git push origin dev
git push origin qa
git push origin qa1
git push origin stage

# Manual approval required
git push origin pre-prod   # Go to Actions tab → Approve
git push origin prod       # Go to Actions tab → Approve
```
