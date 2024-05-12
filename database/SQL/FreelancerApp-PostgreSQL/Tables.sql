DROP TABLE IF EXISTS freelancers CASCADE;
DROP TABLE IF EXISTS profile_views CASCADE;
DROP TABLE IF EXISTS featured_team_member CASCADE;
DROP TABLE IF EXISTS portfolios CASCADE;
DROP TABLE IF EXISTS portfolio_skills CASCADE;
DROP TABLE IF EXISTS portfolio_views CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS service_views CASCADE;
DROP TABLE IF EXISTS service_skills CASCADE;
DROP TABLE IF EXISTS portfolio_service CASCADE;
DROP TABLE IF EXISTS dedicated_resource CASCADE;
DROP TABLE IF EXISTS resource_views CASCADE;
DROP TABLE IF EXISTS resource_skills CASCADE;
DROP TABLE IF EXISTS portfolio_resource CASCADE;
DROP TABLE IF EXISTS quotes CASCADE;
DROP TABLE IF EXISTS quote_templates CASCADE;
DROP TABLE IF EXISTS job_watchlist CASCADE;
DROP TABLE IF EXISTS job_invitations CASCADE;
DROP TYPE IF EXISTS user_type_enum CASCADE;
DROP TYPE IF EXISTS resource_duration_enum CASCADE;
DROP TYPE IF EXISTS quote_status_enum CASCADE;
DROP TYPE IF EXISTS team_member_type CASCADE;
DROP TYPE IF EXISTS team_member_role CASCADE;

CREATE TYPE user_type_enum AS ENUM ('INDIVIDUAL', 'COMPANY');
CREATE TYPE resource_duration_enum AS ENUM ('3Months', '6Months','1Year','Ongoing');
CREATE TYPE quote_status_enum AS ENUM ('AWAITING_ACCEPTANCE', 'PRIORITY', 'ACCEPTED', 'ARCHIVED');
CREATE TYPE team_member_type AS ENUM ('INDEPENDENT_ACCOUNTS', 'SUB_ACCOUNTS', 'NO_ACCESS_MEMBERS');
CREATE TYPE team_member_role AS ENUM ('CONSULTANT', 'MANAGER');

--CREATE TABLE jobs (
--		job_id uuid PRIMARY KEY
--);

CREATE TABLE freelancers (
    freelancer_id UUID PRIMARY KEY,
    freelancer_name VARCHAR(50),
    image_url VARCHAR(255),
    visibility BOOLEAN,
    profile_views INT DEFAULT 0,
    job_invitations_num INT,
    available_bids INT,
    all_time_earnings DECIMAL,
    employers_num INT,
    highest_paid DECIMAL,
    membership_date TIMESTAMP,
    tagline VARCHAR(190),
    bio VARCHAR(3000),
    work_terms VARCHAR(2000),
    attachments VARCHAR(255) ARRAY,
    user_type varchar(255) CHECK (user_type IN ('INDIVIDUAL','COMPANY')),
    website_link VARCHAR(255),
    facebook_link VARCHAR(255),
    linkedin_link VARCHAR(255),
    professional_video_link VARCHAR(255),
    company_history VARCHAR(3000),
    operating_since TIMESTAMP
);

CREATE TABLE profile_views(
    freelancer_id UUID PRIMARY KEY,
    viewer_id UUID,
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(freelancer_id) ON DELETE CASCADE
);

CREATE TABLE featured_team_member (
    team_member_id UUID PRIMARY KEY,
    freelancer_id UUID,
    member_name VARCHAR(255),
    title VARCHAR(255) CHECK (title IN ('CONSULTANT', 'MANAGER')),
    member_type VARCHAR(255) CHECK (member_type IN ('INDEPENDENT_ACCOUNTS', 'SUB_ACCOUNTS', 'NO_ACCESS_MEMBERS')),
    member_email VARCHAR(255),
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(freelancer_id) ON DELETE CASCADE
);

CREATE TABLE portfolios (
    portfolio_id UUID PRIMARY KEY,    
    freelancer_id UUID,
    title VARCHAR(255),
    cover_image_url VARCHAR(255),    
    attachments varchar(255) ARRAY,
    is_draft BOOLEAN,    
    portfolio_views INT DEFAULT 0,
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(freelancer_id) ON DELETE CASCADE  
);

CREATE TABLE portfolio_skills (
    portfolio_id UUID,
    skill_id UUID,
    PRIMARY KEY (portfolio_id, skill_id),
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE portfolio_views(
    portfolio_id UUID PRIMARY KEY,
    viewer_id UUID,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE
);

CREATE TABLE services (
    service_id UUID PRIMARY KEY,
    freelancer_id UUID,
    service_title VARCHAR(255),
    service_description VARCHAR(5000),
    service_rate DECIMAL,
    minimum_budget DECIMAL,
    service_thumbnail VARCHAR(255),  
    service_views INT DEFAULT 0,
    is_draft BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(freelancer_id) ON DELETE CASCADE  
);

CREATE TABLE service_views(
    service_id UUID PRIMARY KEY,
    viewer_id UUID,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

CREATE TABLE service_skills (
    service_id UUID,
    skill_id UUID,
    PRIMARY KEY (service_id, skill_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE portfolio_service (
    service_id UUID,
    portfolio_id UUID,
    PRIMARY KEY (service_id, portfolio_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE      
);

CREATE TABLE dedicated_resource (
    resource_id UUID PRIMARY KEY,
    freelancer_id UUID,
    resource_name VARCHAR(255),
    resource_title VARCHAR(255), 
    resource_summary VARCHAR(3000),
    resource_rate DECIMAL,
    minimum_duration varchar(255) check (minimum_duration in ('3Months', '6Months','1Year','Ongoing')),
    resource_image VARCHAR(255),
    resource_views INT DEFAULT 0,
    is_draft BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(freelancer_id) ON DELETE CASCADE
);

CREATE TABLE resource_views(
    resource_id UUID PRIMARY KEY,
    viewer_id UUID,
    FOREIGN KEY (resource_id) REFERENCES dedicated_resource(resource_id) ON DELETE CASCADE
);

CREATE TABLE resource_skills (
    resource_id UUID,
    skill_id UUID,
    PRIMARY KEY (resource_id, skill_id),
    FOREIGN KEY (resource_id) REFERENCES dedicated_resource(resource_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE portfolio_resource (
    resource_id UUID,
    portfolio_id UUID,
    PRIMARY KEY (resource_id, portfolio_id),
    FOREIGN KEY (resource_id) REFERENCES dedicated_resource(resource_id) ON DELETE CASCADE,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE    
);



