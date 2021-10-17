using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using Microsoft.EntityFrameworkCore;
using cumin_api.Middlewares;
using cumin_api.Services;
using cumin_api.Others;
using System.Net;
using cumin_api.Filters;
using System.Collections.Generic;
using Microsoft.AspNetCore.Http;
using System.Diagnostics;
using Microsoft.Extensions.Logging;

namespace cumin_api {
    public class Startup {
        private readonly string AllowSpecificOriginCorsPolicy = "AllowSpecificOriginCorsPolicy";
        private readonly string FrontendUrl = "http://localhost:3000";


        public Startup(IConfiguration configuration, IHostEnvironment enviroment) {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services) {
            services.AddAutoMapper(typeof(Startup));
            // added
            //services.AddHttpsRedirection(options =>
            //{
            //    options.RedirectStatusCode = (int)HttpStatusCode.PermanentRedirect;
            //    options.HttpsPort = 5001;
            //});
            services.Configure<ForwardedHeadersOptions>(options => options.ForwardedHeaders = Microsoft.AspNetCore.HttpOverrides.ForwardedHeaders.XForwardedFor | Microsoft.AspNetCore.HttpOverrides.ForwardedHeaders.XForwardedProto);

            services.AddCors(options =>
                options.AddPolicy(AllowSpecificOriginCorsPolicy, builder => {
                    builder.WithOrigins(new[] { FrontendUrl }).AllowAnyHeader().AllowAnyMethod().AllowCredentials();
                })
            );

            services.AddControllers();

            services.Configure<SecurityConfiguration>(Configuration.GetSection("Security"));
            
            services.AddDbContext<CuminApiContext>(options => options.UseMySql(Configuration.GetConnectionString("Default"), new MySqlServerVersion(new Version(8, 0, 25))));
            services.AddScoped<TokenHelper, TokenHelper>();

            // Db Services
            services.AddScoped<Services.v2.IssueService, Services.v2.IssueService>();
            services.AddScoped<Services.v2.UserService, Services.v2.UserService>();
            services.AddScoped<Services.v2.SprintService, Services.v2.SprintService>();
            services.AddScoped<Services.v2.ProjectService, Services.v2.ProjectService>();
            services.AddScoped<Services.v2.EpicService, Services.v2.EpicService>();
            services.AddScoped<Services.v2.PathService, Services.v2.PathService>();
            services.AddScoped<Services.v2.InvitationService, Services.v2.InvitationService>();


            // filters
            services.AddScoped<ProjectUrlBasedAuthorizationFilter>();
            services.AddScoped<RoleAuthorizationFilter>();
            services.AddSingleton<HubUserService>();

            services.AddSignalR();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, CuminApiContext dbContext, ILogger<Startup> logger) {
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage();
            }
            else {
                dbContext.Database.Migrate();
            }

            //Action<IHeaderDictionary> printHeaders = delegate (IHeaderDictionary headers) {
            //    foreach (var pair in headers) {
            //        logger.LogDebug(String.Format("{0, -15} = {1,  15}", pair.Key, pair.Value.ToString()));
            //    }
            //};

            app.Use(async (context, next) => {
                //printHeaders(context.Request.Headers);
                await next();
            });

            app.UseForwardedHeaders();
            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors(AllowSpecificOriginCorsPolicy);

            app.UseAuthorization();

            app.UseMiddleware<JwtTokenMiddleware>(); 

            app.UseEndpoints(endpoints => {
                endpoints.MapControllers();
                endpoints.MapHub<NotificationHub>("/notification");
            });
        }
    }
}
