<%-- 
    Document   : Sign_in_controller
    Created on : 05/08/2019, 13:39:31
    Author     : Marcos
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="utils.Ferramentas"%>
<%@page import="Dao.UserDAO"%>
<%@page import="Dao.ClienteDAO"%>
<%@page import="Bean.Cliente"%>
<%@page import="japplets.EmitirNFCE"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html>
  <%@page import="Dao.LoginDAO"%>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Insert title here</title>
  </head>
  <body>
   <jsp:useBean id="obj_Login_Bean" class="Bean.Cliente"></jsp:useBean>
   <jsp:setProperty property="*" name="obj_Login_Bean"/>
   <%
    
     
     boolean flag = false;
     boolean flag1 = false;
     boolean verificador = true;
     String erro = "Erro desconhecido";
     
        obj_Login_Bean.setPermissão("1");
     
      System.out.println("--------------------------------");
        System.out.println(obj_Login_Bean.getNfce());
        System.out.println(obj_Login_Bean.getLicenca());
        System.out.println(obj_Login_Bean.getUser());
        System.out.println(obj_Login_Bean.getPass());
        System.out.println(obj_Login_Bean.getCsenha());
        System.out.println(obj_Login_Bean.getNome());
        System.out.println(obj_Login_Bean.getCnpj());
        System.out.println("Nome Fantasia: " + obj_Login_Bean.getBb());
        System.out.println("Razao Social: " + obj_Login_Bean.getAa());
        System.out.println(obj_Login_Bean.getEstado());
        System.out.println(obj_Login_Bean.getTelefone());
        System.out.println(obj_Login_Bean.getCep());
        System.out.println(obj_Login_Bean.getEndereco());
        System.out.println(obj_Login_Bean.getNumero());
        System.out.println(obj_Login_Bean.getComplemento());
        System.out.println(obj_Login_Bean.getBairro());
        System.out.println(obj_Login_Bean.getCidade());
        System.out.println("Data Inicio: "+ obj_Login_Bean.getDatainicio());
        System.out.println("Prazo Licença: "+obj_Login_Bean.getPrazo_licença());
        System.out.println(obj_Login_Bean.getPacote());
        System.out.println(obj_Login_Bean.getPermissão());
        System.out.println(obj_Login_Bean.getLogo());
        System.out.println(obj_Login_Bean.getEmail());
     System.out.println("--------------------------------");
     
     //Verifica os dados
       if(obj_Login_Bean.getUser()==null || obj_Login_Bean.getPass()==null
       || obj_Login_Bean.getCsenha()==null || obj_Login_Bean.getNome()==null
       || obj_Login_Bean.getEstado()==null || obj_Login_Bean.getTelefone()==null 
       || obj_Login_Bean.getCep()==null  || obj_Login_Bean.getEndereco()==null 
       || obj_Login_Bean.getNumero()==null || obj_Login_Bean.getComplemento()==null 
       || obj_Login_Bean.getBairro()==null || obj_Login_Bean.getCidade()==null  
       || obj_Login_Bean.getEmail()==null || obj_Login_Bean.getCpf()==null
               || obj_Login_Bean.getCategoria()==null ){
            verificador = false;
            erro = " Complete todos os campos obrigatórios!";
        }else{
            if(!obj_Login_Bean.getPass().toString().equals( obj_Login_Bean.getCsenha().toString())){
                verificador = false;
                erro = "Senhas não conferem!";
            }else{
                Ferramentas f = new Ferramentas();
                if(!f.isCPF(obj_Login_Bean.getCpf().replaceAll("[^0-9]", ""))){
                   verificador = false;
                  erro = "CPF Inválido!"; 
                }else{
                    if(obj_Login_Bean.getTipo_veiculo().equals("")){
                        if(obj_Login_Bean.getPlaca()==null
                            || obj_Login_Bean.getMarca()==null
                            || obj_Login_Bean.getModelo()==null
                            || obj_Login_Bean.getCor()==null){
                            verificador = false;
                            erro = "Complete Informações do carro";
                        }
                    }
                }
                
            }
        }
     obj_Login_Bean.setPacote("Entregador");
     //Verifica E-mail
     ClienteDAO cdao = new ClienteDAO();
     if(cdao.Ver_Email(obj_Login_Bean.getEmail())){
         verificador = false;
         erro = "E-mail já Cadastrado!"; 
     }
     //Verificar User
     System.out.println("-----iiiiiiiii: "+obj_Login_Bean.getUser());
    if(cdao.Ver_User(obj_Login_Bean.getUser())){
         verificador = false;
         erro = "Nome de Usuario indisponivel!"; 
     }
    
    if(obj_Login_Bean.getCnpj() == null){
        obj_Login_Bean.setCnpj("invalido");
    }
    
     if(verificador==true){
         try{
            //Salva o cliente
            System.out.println("AQui");
            
            flag = cdao.save(obj_Login_Bean);
            System.out.println("AQui 2");
         }catch(Exception e){erro = "Erro ao Cadastrar Usuario";flag=false;}
         try{
             //Salva o Ususario
             System.out.println("AQu3");
             UserDAO udao = new UserDAO();
             flag1 = udao.save(obj_Login_Bean);
             System.out.println("AQui4");
         }catch(Exception e){erro = "Erro ao Cadastrar Usuario";flag1=false;}
     }
    
    if(flag && flag1){
      response.setContentType("text/html");
            PrintWriter pw=response.getWriter();
            pw.println("<script type=\"text/javascript\">");
            pw.println("alert('Cliente Cadastrado com sucesso!');");
            pw.println("</script>");
    %>
    <script type="text/javascript">
       window.location.href="http://localhost:8080/GibGas/login.html";
    </script>
  <%
}else{
            response.setContentType("text/html");
            PrintWriter pw=response.getWriter();
            pw.println("<script type=\"text/javascript\">");
            pw.println("alert('"+erro+"');");
            pw.println("</script>");
            
  %>
  <script type="text/javascript">
   history.back();
   </script>
  <%
 }
 %>
 </body>
 </html>
