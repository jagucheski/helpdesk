package br.gov.rs.parobe.helpdesk.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;


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
			.antMatchers("/home").permitAll()
			.anyRequest().authenticated()
			.and()
				.formLogin().loginPage("/").defaultSuccessUrl("/home").permitAll()
			.and()
				.logout()
	            .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).permitAll() 
	            .logoutSuccessUrl("/");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(usuarioDao)
				.passwordEncoder(new BCryptPasswordEncoder());
	}
	
    /**
     * Para o filtro de segurança ignorar as requisições para recursos estáticos
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**");
    }
}
