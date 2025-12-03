%rebase('layout', title='Usuários')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title">Gestão de Usuários</h1>
        <a href="/users/add" class="btn btn-primary">Novo Usuário</a>
    </div>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Data Nasc.</th>
                    <th>Tipo</th>
                    <th>Ações</th>
                </tr>
            </thead>

            <tbody>
                % for u in users:
                <tr>
                    <td>{{u.id}}</td>
                    <td>{{u.nome if hasattr(u, 'nome') else u.name}}</td>  <!-- MUDOU AQUI -->
                    <td><a href="mailto:{{u.email}}">{{u.email}}</a></td>
                    <td>{{u.birthdate}}</td>
                    <td>{{u.tipo if hasattr(u, 'tipo') else 'comum'}}</td>  <!-- NOVO -->
                    <td class="actions">
                        <a href="/users/edit/{{u.id}}" class="btn btn-sm btn-edit">Editar</a>

                        <form action="/users/delete/{{u.id}}" method="post" 
                              onsubmit="return confirm('Tem certeza?')">
                            <button type="submit" class="btn btn-sm btn-danger">Excluir</button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>