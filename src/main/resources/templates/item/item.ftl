<!DOCTYPE html>
<html lang="en">
<head id="head">
    <title>Items</title>
    <#include "../stubs/header.ftl">
</head>
    <body id="body">

        <#include "../stubs/navbar.ftl">

        <!-- content -->
        <div id="content" class="container">
            <!-- add/edit -->
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading">Add or Update Item <span class="pull-right"><a href="/secure/item">Add New</a></span></div>
                    <div class="panel-body">
                        <form role="form" method="post" action="/secure/item">
                            <#if item??>
                                <div class="form-group">
                                    <label>Created On:</label><span> ${(item.creation?number_to_datetime)!}</span> <br/>
                                    <label>Last Seen:</label><span> ${(item.lastSeen?number_to_datetime)!}</span> <br/>
                                    <label>Account: </label>
                                    <a href="/secure/item/${(item.id)!}
                                        ${(item.active==1)?string('?active=false','?active=true')}">
                                            ${(item.active==1)?string('Enabled (click to disable)','Disabled (click to enable)')}
                                    </a> <br/>
                                </div>
                            </#if>
                            <div class="form-group">
                                <input type="text" id="name" name="name" value="${(item.name)!}" class="form-control" placeholder="Name" required="true" autofocus="true"/>
                            </div>
                            <div class="form-group">
                                <input type="email" id="email" name="email" value="${(item.email)!}" class="form-control" placeholder="Email" required="true"/>
                            </div>
                            <div class="form-group">
                                <input type="text" id="itemname" name="itemname" value="${(item.itemname)!}" class="form-control" placeholder="Itemname" required="true"/>
                            </div>
                            <div class="form-group">
                                <input type="password" id="password" name="password" value="${(item.password)!}" class="form-control" placeholder="Password" required="true"/>
                            </div>
                            <input type="hidden" name="id" value="${(item.id)!}"/>
                            <input type="hidden" name="creation" value="${(item.creation?c)!}"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- add/edit -->
            <!-- view all -->
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading">Current Items</div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Itemname</th>
                                    <th>Enabled</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#list items as item>
                                        <tr>
                                            <td>${(item.name)!}</td>
                                            <td>${(item.email)!}</td>
                                            <td>${(item.itemname)!}</td>
                                            <td>${(item.active == 1)?c}</td>
                                            <td>
                                                <a href="/secure/item/${(item.id)!}" class="btn btn-xs btn-primary">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                                <a href="#" class="btn btn-danger btn-xs" data-id="${(item.id)!}" data-toggle="modal" data-target="#deleteCheck">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- view all -->
        </div>

        <div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Are you sure?</h4>
                    </div>
                    <div class="modal-body">
                        Permantly remove item? This action cannot be undone.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel</button>
                        <span id="delete">
                            <form role="form" method="post" action="/secure/item/{id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-primary btn-md">Yes, Remove Item</button>
                            </form>
                        </span>

                    </div>
                </div>
            </div>
        </div>

        <!-- content -->

        <#include "../stubs/footer.ftl">

        <#include "../stubs/scripts.ftl">

        <script>
            $(document).ready(function() {

                // toggle safe delete modal popup
                $('a[data-toggle="modal"]').click(function(){
                    var id = $(this).data('id');
                    var form = $('.modal #delete');
                    form.html(form.html().replace('{id}',id));
                });
            });
        </script>

    </body>
</html>
