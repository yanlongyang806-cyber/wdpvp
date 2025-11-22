# Git 仓库设置说明

## 本地仓库状态

✅ 本地 Git 仓库已创建
✅ 初始提交已完成
✅ 包含 8 个文件

## 仓库信息

- **仓库位置**: `_upload_pvp/`
- **当前分支**: `master`
- **初始提交**: `f2e80b0` - "Initial commit: 全地图强制PVP修改"

## 连接到远程仓库

### 方法 1: 在 GitHub/GitLab 创建新仓库后连接

```bash
cd _upload_pvp

# 添加远程仓库（替换为您的实际仓库地址）
git remote add origin https://github.com/yourusername/pvp-force-mod.git

# 或者使用 SSH
git remote add origin git@github.com:yourusername/pvp-force-mod.git

# 推送到远程仓库
git push -u origin master
```

### 方法 2: 在 GitHub/GitLab 创建新仓库时
1. 在 GitHub/GitLab 创建新仓库（不要初始化 README）
2. 按照方法 1 的步骤连接并推送

### 方法 3: 使用 GitHub CLI

```bash
cd _upload_pvp

# 如果已安装 GitHub CLI
gh repo create pvp-force-mod --public --source=. --remote=origin --push
```

## 查看仓库状态

```bash
cd _upload_pvp

# 查看提交历史
git log --oneline

# 查看文件状态
git status

# 查看远程仓库
git remote -v
```

## 文件列表

当前仓库包含以下文件：

1. `CrossRoads/Common/pvp_common.c` - 修改后的源代码
2. `README.md` - 项目说明文档
3. `DEPENDENCIES.md` - 依赖分析文档
4. `BUILD_REQUIREMENTS.txt` - 编译要求
5. `CHANGELOG.txt` - 变更日志
6. `INSTALL.txt` - 安装说明
7. `patch.diff` - Git 补丁文件
8. `.gitignore` - Git 忽略规则

## 后续操作

### 添加新的修改

```bash
cd _upload_pvp

# 修改文件后
git add .
git commit -m "描述修改内容"
git push
```

### 创建新分支

```bash
cd _upload_pvp
git checkout -b feature/new-feature
# 进行修改...
git add .
git commit -m "新功能描述"
git push -u origin feature/new-feature
```

## 注意事项

1. 仓库已配置 `.gitignore`，会自动忽略编译生成的文件
2. 所有文档使用 UTF-8 编码
3. 提交信息建议使用中文（已设置）
4. 如果需要修改用户信息：

```bash
cd _upload_pvp
git config user.name "您的名字"
git config user.email "您的邮箱"
```

