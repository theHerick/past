<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FileShare - Transferência Temporária de Arquivos</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
            padding: 20px;
        }

        header h1 {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
        }

        main {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        .plans-section h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .plans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .plan-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            position: relative;
            transition: transform 0.3s, box-shadow 0.3s;
            border: 2px solid #e0e0e0;
        }

        .plan-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .plan-card.popular {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            transform: scale(1.05);
        }

        .plan-badge {
            position: absolute;
            top: -10px;
            right: 20px;
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
        }

        .popular-badge {
            background: #ffd700;
            color: #333;
        }

        .plan-card h3 {
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .plan-price {
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .plan-price span {
            font-size: 0.4em;
            opacity: 0.8;
        }

        .plan-features {
            list-style: none;
            margin-bottom: 25px;
        }

        .plan-features li {
            padding: 10px 0;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            font-size: 1em;
        }

        .plan-card.popular .plan-features li {
            border-bottom-color: rgba(255,255,255,0.2);
        }

        .btn-select {
            width: 100%;
            padding: 15px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-select:hover {
            background: #5568d3;
        }

        .plan-card.popular .btn-select {
            background: white;
            color: #667eea;
        }

        .plan-card.popular .btn-select:hover {
            background: #f0f0f0;
        }

        .upload-section {
            animation: fadeIn 0.5s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .upload-section h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .upload-container {
            max-width: 700px;
            margin: 0 auto;
        }

        .folder-info {
            background: #f0f4ff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #d0d7e8;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #555;
        }

        .info-value {
            color: #667eea;
            font-weight: bold;
        }

        .folder-name-input,
        .password-input {
            margin-bottom: 25px;
        }

        .folder-name-input label,
        .password-input label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }

        .folder-name-input input,
        .password-input input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }

        .folder-name-input input:focus,
        .password-input input:focus {
            outline: none;
            border-color: #667eea;
        }

        .upload-area {
            border: 3px dashed #d0d0d0;
            border-radius: 15px;
            padding: 60px 20px;
            text-align: center;
            background: #fafafa;
            transition: all 0.3s;
            cursor: pointer;
        }

        .upload-area.dragover {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .upload-icon {
            font-size: 4em;
            margin-bottom: 15px;
        }

        .upload-text {
            font-size: 1.2em;
            color: #555;
            margin-bottom: 10px;
        }

        .upload-hint {
            color: #999;
            font-size: 0.9em;
            margin-bottom: 20px;
        }

        .btn-upload {
            padding: 12px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-upload:hover {
            background: #5568d3;
        }

        .files-list {
            margin-top: 25px;
        }

        .file-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .file-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .file-icon {
            font-size: 1.5em;
        }

        .file-details {
            display: flex;
            flex-direction: column;
        }

        .file-name {
            font-weight: 600;
            color: #333;
        }

        .file-size {
            font-size: 0.85em;
            color: #999;
        }

        .btn-remove {
            background: #ff4757;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-remove:hover {
            background: #e63946;
        }

        .upload-progress {
            margin-top: 25px;
        }

        .progress-bar {
            width: 100%;
            height: 30px;
            background: #e0e0e0;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            width: 0%;
            transition: width 0.3s;
        }

        .progress-text {
            text-align: center;
            font-weight: bold;
            color: #667eea;
        }

        .btn-create {
            width: 100%;
            padding: 18px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            margin-top: 25px;
            transition: background 0.3s;
        }

        .btn-create:hover {
            background: #218838;
        }

        .link-section {
            animation: fadeIn 0.5s;
        }

        .link-section h2 {
            text-align: center;
            color: #28a745;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .link-container {
            max-width: 700px;
            margin: 0 auto;
        }

        .link-box {
            background: #f0f4ff;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }

        .link-label {
            font-weight: 600;
            color: #555;
            margin-bottom: 15px;
        }

        .link-display {
            display: flex;
            gap: 10px;
        }

        .link-display input {
            flex: 1;
            padding: 15px;
            border: 2px solid #667eea;
            border-radius: 8px;
            font-size: 1em;
            background: white;
        }

        .btn-copy {
            padding: 15px 25px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-copy:hover {
            background: #5568d3;
        }

        .btn-copy.copied {
            background: #28a745;
        }

        .link-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 15px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
        }

        .info-icon {
            font-size: 2em;
        }

        .link-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn-primary,
        .btn-secondary {
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
        }

        .btn-secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #e9ecef;
        }

        footer {
            text-align: center;
            color: white;
            margin-top: 40px;
            padding: 20px;
            opacity: 0.8;
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 2em;
            }
            
            .plans-grid {
                grid-template-columns: 1fr;
            }
            
            .plan-card.popular {
                transform: scale(1);
            }
            
            main {
                padding: 20px;
            }
            
            .link-actions {
                flex-direction: column;
            }
            
            .btn-primary,
            .btn-secondary {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📁 FileShare</h1>
            <p class="subtitle">Compartilhe arquivos de forma rápida e temporária</p>
        </header>

        <main>
            <!-- Seção de Planos -->
            <section class="plans-section">
                <h2>Escolha seu Plano</h2>
                <div class="plans-grid">
                    <div class="plan-card" data-plan="free">
                        <div class="plan-badge">Grátis</div>
                        <h3>Básico</h3>
                        <div class="plan-price">R$ 0</div>
                        <ul class="plan-features">
                            <li>✓ Até 100MB</li>
                            <li>✓ Válido por 24 horas</li>
                            <li>✓ Link compartilhável</li>
                            <li>✓ Sem cadastro</li>
                        </ul>
                        <button class="btn-select" onclick="selectPlan('free', 100)">Selecionar</button>
                    </div>

                    <div class="plan-card popular" data-plan="pro">
                        <div class="plan-badge popular-badge">Mais Popular</div>
                        <h3>Pro</h3>
                        <div class="plan-price">R$ 9,90<span>/mês</span></div>
                        <ul class="plan-features">
                            <li>✓ Até 1GB</li>
                            <li>✓ Válido por 7 dias</li>
                            <li>✓ Link personalizado</li>
                            <li>✓ Senha de proteção</li>
                            <li>✓ 10 pastas simultâneas</li>
                        </ul>
                        <button class="btn-select" onclick="selectPlan('pro', 1024)">Selecionar</button>
                    </div>

                    <div class="plan-card" data-plan="premium">
                        <div class="plan-badge">Premium</div>
                        <h3>Premium</h3>
                        <div class="plan-price">R$ 19,90<span>/mês</span></div>
                        <ul class="plan-features">
                            <li>✓ Até 5GB</li>
                            <li>✓ Válido por 30 dias</li>
                            <li>✓ Link personalizado</li>
                            <li>✓ Senha de proteção</li>
                            <li>✓ Pastas ilimitadas</li>
                            <li>✓ Estatísticas de download</li>
                        </ul>
                        <button class="btn-select" onclick="selectPlan('premium', 5120)">Selecionar</button>
                    </div>
                </div>
            </section>

            <!-- Seção de Upload -->
            <section class="upload-section" id="uploadSection" style="display: none;">
                <h2>Criar Nova Pasta</h2>
                <div class="upload-container">
                    <div class="folder-info">
                        <div class="info-row">
                            <span class="info-label">Plano Selecionado:</span>
                            <span class="info-value" id="selectedPlan">-</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Limite de Tamanho:</span>
                            <span class="info-value" id="sizeLimit">-</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Validade:</span>
                            <span class="info-value" id="validity">-</span>
                        </div>
                    </div>

                    <div class="folder-name-input">
                        <label for="folderName">Nome da Pasta (opcional):</label>
                        <input type="text" id="folderName" placeholder="Ex: Fotos Férias 2025">
                    </div>

                    <div class="password-input" id="passwordSection" style="display: none;">
                        <label for="folderPassword">Senha de Proteção (opcional):</label>
                        <input type="password" id="folderPassword" placeholder="Digite uma senha">
                    </div>

                    <div class="upload-area" id="uploadArea">
                        <div class="upload-icon">📤</div>
                        <p class="upload-text">Arraste arquivos aqui ou clique para selecionar</p>
                        <p class="upload-hint">Você pode adicionar vários arquivos</p>
                        <input type="file" id="fileInput" multiple hidden>
                        <button class="btn-upload" onclick="document.getElementById('fileInput').click()">
                            Selecionar Arquivos
                        </button>
                    </div>

                    <div class="files-list" id="filesList"></div>

                    <div class="upload-progress" id="uploadProgress" style="display: none;">
                        <div class="progress-bar">
                            <div class="progress-fill" id="progressFill"></div>
                        </div>
                        <p class="progress-text" id="progressText">0%</p>
                    </div>

                    <button class="btn-create" id="btnCreate" onclick="createFolder()" style="display: none;">
                        Criar Pasta e Gerar Link
                    </button>
                </div>
            </section>

            <!-- Seção de Link Gerado -->
            <section class="link-section" id="linkSection" style="display: none;">
                <h2>🎉 Pasta Criada com Sucesso!</h2>
                <div class="link-container">
                    <div class="link-box">
                        <div class="link-label">Seu link de compartilhamento:</div>
                        <div class="link-display">
                            <input type="text" id="generatedLink" readonly>
                            <button class="btn-copy" onclick="copyLink()">
                                <span id="copyText">Copiar</span>
                            </button>
                        </div>
                    </div>

                    <div class="link-info">
                        <div class="info-item">
                            <span class="info-icon">📊</span>
                            <div>
                                <strong>Tamanho Total:</strong>
                                <span id="totalSize">-</span>
                            </div>
                        </div>
                        <div class="info-item">
                            <span class="info-icon">📁</span>
                            <div>
                                <strong>Arquivos:</strong>
                                <span id="fileCount">-</span>
                            </div>
                        </div>
                        <div class="info-item">
                            <span class="info-icon">⏰</span>
                            <div>
                                <strong>Expira em:</strong>
                                <span id="expiryTime">-</span>
                            </div>
                        </div>
                        <div class="info-item" id="passwordInfo" style="display: none;">
                            <span class="info-icon">🔒</span>
                            <div>
                                <strong>Protegido com senha</strong>
                            </div>
                        </div>
                    </div>

                    <div class="link-actions">
                        <button class="btn-secondary" onclick="openLink()">
                            Abrir Link
                        </button>
                        <button class="btn-primary" onclick="createAnother()">
                            Criar Outra Pasta
                        </button>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 FileShare - Transferência temporária de arquivos de forma simples e rápida</p>
        </footer>
    </div>

    <script>
        // Estado da aplicação
        let currentPlan = null;
        let maxSize = 0;
        let selectedFiles = [];
        let totalFileSize = 0;

        // Configurações dos planos
        const planConfigs = {
            free: {
                name: 'Básico (Grátis)',
                maxSize: 100,
                validity: '24 horas',
                validityHours: 24,
                hasPassword: false
            },
            pro: {
                name: 'Pro',
                maxSize: 1024,
                validity: '7 dias',
                validityHours: 168,
                hasPassword: true
            },
            premium: {
                name: 'Premium',
                maxSize: 5120,
                validity: '30 dias',
                validityHours: 720,
                hasPassword: true
            }
        };

        // Selecionar plano
        function selectPlan(planType, sizeLimit) {
            currentPlan = planType;
            maxSize = sizeLimit;
            
            const config = planConfigs[planType];
            
            document.getElementById('selectedPlan').textContent = config.name;
            document.getElementById('sizeLimit').textContent = `${sizeLimit >= 1024 ? (sizeLimit/1024).toFixed(1) + ' GB' : sizeLimit + ' MB'}`;
            document.getElementById('validity').textContent = config.validity;
            
            const passwordSection = document.getElementById('passwordSection');
            if (config.hasPassword) {
                passwordSection.style.display = 'block';
            } else {
                passwordSection.style.display = 'none';
            }
            
            document.getElementById('uploadSection').style.display = 'block';
            document.getElementById('uploadSection').scrollIntoView({ behavior: 'smooth' });
            
            selectedFiles = [];
            totalFileSize = 0;
            updateFilesList();
        }

        // Configurar drag and drop
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');

        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            
            const files = Array.from(e.dataTransfer.files);
            addFiles(files);
        });

        fileInput.addEventListener('change', (e) => {
            const files = Array.from(e.target.files);
            addFiles(files);
        });

        // Adicionar arquivos
        function addFiles(files) {
            for (let file of files) {
                const fileSizeMB = file.size / (1024 * 1024);
                
                if (totalFileSize + fileSizeMB > maxSize) {
                    alert(`Não é possível adicionar "${file.name}". Limite de ${maxSize >= 1024 ? (maxSize/1024).toFixed(1) + ' GB' : maxSize + ' MB'} seria excedido.`);
                    continue;
                }
                
                selectedFiles.push(file);
                totalFileSize += fileSizeMB;
            }
            
            updateFilesList();
        }

        // Atualizar lista de arquivos
        function updateFilesList() {
            const filesList = document.getElementById('filesList');
            const btnCreate = document.getElementById('btnCreate');
            
            if (selectedFiles.length === 0) {
                filesList.innerHTML = '';
                btnCreate.style.display = 'none';
                return;
            }
            
            filesList.innerHTML = '<h3 style="margin-bottom: 15px; color: #333;">Arquivos Selecionados:</h3>';
            
            selectedFiles.forEach((file, index) => {
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                
                const fileInfo = document.createElement('div');
                fileInfo.className = 'file-info';
                
                const fileIcon = document.createElement('div');
                fileIcon.className = 'file-icon';
                fileIcon.textContent = getFileIcon(file.name);
                
                const fileDetails = document.createElement('div');
                fileDetails.className = 'file-details';
                
                const fileName = document.createElement('div');
                fileName.className = 'file-name';
                fileName.textContent = file.name;
                
                const fileSize = document.createElement('div');
                fileSize.className = 'file-size';
                fileSize.textContent = formatFileSize(file.size);
                
                fileDetails.appendChild(fileName);
                fileDetails.appendChild(fileSize);
                
                fileInfo.appendChild(fileIcon);
                fileInfo.appendChild(fileDetails);
                
                const btnRemove = document.createElement('button');
                btnRemove.className = 'btn-remove';
                btnRemove.textContent = 'Remover';
                btnRemove.onclick = () => removeFile(index);
                
                fileItem.appendChild(fileInfo);
                fileItem.appendChild(btnRemove);
                
                filesList.appendChild(fileItem);
            });
            
            const totalInfo = document.createElement('div');
            totalInfo.style.marginTop = '15px';
            totalInfo.style.padding = '15px';
            totalInfo.style.background = '#f0f4ff';
            totalInfo.style.borderRadius = '8px';
            totalInfo.style.fontWeight = 'bold';
            totalInfo.innerHTML = `
                <span style="color: #555;">Total:</span>
                <span style="color: #667eea; float: right;">
                    ${totalFileSize.toFixed(2)} MB / ${maxSize >= 1024 ? (maxSize/1024).toFixed(1) + ' GB' : maxSize + ' MB'}
                </span>
            `;
            filesList.appendChild(totalInfo);
            
            btnCreate.style.display = 'block';
        }

        // Remover arquivo
        function removeFile(index) {
            const file = selectedFiles[index];
            const fileSizeMB = file.size / (1024 * 1024);
            totalFileSize -= fileSizeMB;
            selectedFiles.splice(index, 1);
            updateFilesList();
        }

        // Obter ícone do arquivo
        function getFileIcon(fileName) {
            const ext = fileName.split('.').pop().toLowerCase();
            
            const iconMap = {
                'pdf': '📄', 'doc': '📝', 'docx': '📝',
                'xls': '📊', 'xlsx': '📊', 'ppt': '📊', 'pptx': '📊',
                'jpg': '🖼️', 'jpeg': '🖼️', 'png': '🖼️', 'gif': '🖼️',
                'mp4': '🎥', 'avi': '🎥', 'mov': '🎥',
                'mp3': '🎵', 'wav': '🎵',
                'zip': '🗜️', 'rar': '🗜️',
                'txt': '📃'
            };
            
            return iconMap[ext] || '📎';
        }

        // Formatar tamanho do arquivo
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            
            return Math.round((bytes / Math.pow(k, i)) * 100) / 100 + ' ' + sizes[i];
        }

        // Criar pasta
        function createFolder() {
            if (selectedFiles.length === 0) {
                alert('Por favor, adicione pelo menos um arquivo.');
                return;
            }
            
            const uploadProgress = document.getElementById('uploadProgress');
            const progressFill = document.getElementById('progressFill');
            const progressText = document.getElementById('progressText');
            const btnCreate = document.getElementById('btnCreate');
            
            uploadProgress.style.display = 'block';
            btnCreate.disabled = true;
            btnCreate.style.opacity = '0.6';
            btnCreate.style.cursor = 'not-allowed';
            
            let progress = 0;
            const interval = setInterval(() => {
                progress += Math.random() * 15;
                if (progress > 100) progress = 100;
                
                progressFill.style.width = progress + '%';
                progressText.textContent = Math.round(progress) + '%';
                
                if (progress === 100) {
                    clearInterval(interval);
                    setTimeout(() => {
                        showLinkSection();
                    }, 500);
                }
            }, 200);
        }

        // Mostrar seção do link
        function showLinkSection() {
            const folderName = document.getElementById('folderName').value || 'Pasta';
            const password = document.getElementById('folderPassword').value;
            const config = planConfigs[currentPlan];
            
            const uniqueId = generateUniqueId();
            const link = `https://fileshare.app/f/${uniqueId}`;
            
            const expiryDate = new Date();
            expiryDate.setHours(expiryDate.getHours() + config.validityHours);
            
            document.getElementById('generatedLink').value = link;
            document.getElementById('totalSize').textContent = totalFileSize.toFixed(2) + ' MB';
            document.getElementById('fileCount').textContent = selectedFiles.length + ' arquivo(s)';
            document.getElementById('expiryTime').textContent = formatDate(expiryDate);
            
            if (password) {
                document.getElementById('passwordInfo').style.display = 'flex';
            } else {
                document.getElementById('passwordInfo').style.display = 'none';
            }
            
            document.getElementById('uploadSection').style.display = 'none';
            document.getElementById('linkSection').style.display = 'block';
            document.getElementById('linkSection').scrollIntoView({ behavior: 'smooth' });
        }

        // Gerar ID único
        function generateUniqueId() {
            const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            let result = '';
            for (let i = 0; i < 8; i++) {
                result += chars.charAt(Math.floor(Math.random() * chars.length));
            }
            return result;
        }

        // Formatar data
        function formatDate(date) {
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            
            return `${day}/${month}/${year} às ${hours}:${minutes}`;
        }

        // Copiar link
        function copyLink() {
            const linkInput = document.getElementById('generatedLink');
            linkInput.select();
            document.execCommand('copy');
            
            const copyBtn = document.querySelector('.btn-copy');
            const copyText = document.getElementById('copyText');
            
            copyBtn.classList.add('copied');
            copyText.textContent = '✓ Copiado!';
            
            setTimeout(() => {
                copyBtn.classList.remove('copied');
                copyText.textContent = 'Copiar';
            }, 2000);
        }

        // Abrir link
        function openLink() {
            const link = document.getElementById('generatedLink').value;
            window.open(link, '_blank');
        }

        // Criar outra pasta
        function createAnother() {
            selectedFiles = [];
            totalFileSize = 0;
            document.getElementById('folderName').value = '';
            document.getElementById('folderPassword').value = '';
            document.getElementById('fileInput').value = '';
            
            document.getElementById('linkSection').style.display = 'none';
            document.getElementById('uploadSection').style.display = 'block';
            document.getElementById('uploadProgress').style.display = 'none';
            
            const btnCreate = document.getElementById('btnCreate');
            btnCreate.disabled = false;
            btnCreate.style.opacity = '1';
            btnCreate.style.cursor = 'pointer';
            
            updateFilesList();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    </script>
</body>
</html>
