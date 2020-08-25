package br.gov.rs.parobe.helpdesk.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private UsuarioDAO usuarioDao;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
//			.antMatchers("/resources/**").permitAll()
//			.antMatchers("/produtos/form").hasRole("ADMIN")
//			.antMatchers("/produtos").hasRole("ADMIN")
//			.antMatchers("/produtos/").hasRole("ADMIN")
//			.antMatchers("/pagamento/**").permitAll()	
			.antMatchers("/").permitAll()
			.antMatchers("/home").hasRole("USER")
			.antMatchers("/operador").hasRole("ADMIN")
			.antMatchers("/operador/*").hasRole("ADMIN")
			.antMatchers("/operador/operadorEditarPerfil").hasRole("ADMIN")
			
			.antMatchers("/usuario").hasRole("ADMIN")
			.antMatchers("/usuario/*").hasRole("ADMIN")
			.antMatchers("/usuario/usuarioEditarPerfil").hasRole("ADMIN")

			.antMatchers("/solicitante").hasRole("SUP")
			.antMatchers("/solicitante/*").hasRole("SUP")
			
			.antMatchers("/usuarioAlteraDados").hasRole("USER")
			.antMatchers("/atualizarSenhaUsuario").hasRole("USER")
			.anyRequest().authenticated()
			.and()
				.formLogin().loginPage("/login").defaultSuccessUrl("/home").permitAll()
			.and()
				.logout()
	            .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).permitAll() 
	            .logoutSuccessUrl("/login")
	            .and().exceptionHandling().accessDeniedPage("/WEB-INF/views/erros/403.jsp");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(usuarioDao)
				.passwordEncoder(passwordEncoder());
	}
	
    /**
     * Para o filtro de segurança ignorar as requisições para recursos estáticos
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**");
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
