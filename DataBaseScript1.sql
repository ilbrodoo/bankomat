USE [BancomatV2]
GO
/****** Object:  Table [dbo].[Banca]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banca](
	[IdBanca] [int] NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Banca] PRIMARY KEY CLUSTERED 
(
	[IdBanca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clienti]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clienti](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[StatoConto] [bit] NOT NULL,
	[nTentativi] [int] NOT NULL,
	[IdUtente] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Clienti] PRIMARY KEY CLUSTERED 
(
	[IdUtente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContoCorrenti]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContoCorrenti](
	[Clienti] [int] NOT NULL,
	[IdConto] [int] IDENTITY(1,1) NOT NULL,
	[Saldo] [float] NOT NULL,
	[Banca] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[IdConto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funzionalita]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funzionalita](
	[idFunzionalita] [int] IDENTITY(1,1) NOT NULL,
	[NomeFunzione] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Funzionalita] PRIMARY KEY CLUSTERED 
(
	[idFunzionalita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunzioniBanche]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunzioniBanche](
	[Banca] [int] NOT NULL,
	[Funzione] [int] NOT NULL,
 CONSTRAINT [PK_FunzioniBanche] PRIMARY KEY CLUSTERED 
(
	[Banca] ASC,
	[Funzione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimento]    Script Date: 29/09/2023 16:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimento](
	[IdMovimento] [int] IDENTITY(1,1) NOT NULL,
	[Data] [date] NOT NULL,
	[TipoMovimento] [nvarchar](50) NOT NULL,
	[Ora] [datetime] NOT NULL,
	[ContoCorrente] [int] NOT NULL,
 CONSTRAINT [PK_Movimento] PRIMARY KEY CLUSTERED 
(
	[IdMovimento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Banca] ADD  CONSTRAINT [DF_Banca_IdBanca]  DEFAULT ((0)) FOR [IdBanca]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_StatoConto]  DEFAULT ((0)) FOR [StatoConto]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_nTentativi]  DEFAULT ((0)) FOR [nTentativi]
GO
ALTER TABLE [dbo].[ContoCorrenti]  WITH CHECK ADD  CONSTRAINT [FK_ContoCorrenti_Clienti] FOREIGN KEY([Clienti])
REFERENCES [dbo].[Clienti] ([IdUtente])
GO
ALTER TABLE [dbo].[ContoCorrenti] CHECK CONSTRAINT [FK_ContoCorrenti_Clienti]
GO
ALTER TABLE [dbo].[FunzioniBanche]  WITH CHECK ADD  CONSTRAINT [FK_FunzioniBanche_Banca] FOREIGN KEY([Banca])
REFERENCES [dbo].[Banca] ([IdBanca])
GO
ALTER TABLE [dbo].[FunzioniBanche] CHECK CONSTRAINT [FK_FunzioniBanche_Banca]
GO
ALTER TABLE [dbo].[FunzioniBanche]  WITH CHECK ADD  CONSTRAINT [FK_FunzioniBanche_Funzionalita] FOREIGN KEY([Funzione])
REFERENCES [dbo].[Funzionalita] ([idFunzionalita])
GO
ALTER TABLE [dbo].[FunzioniBanche] CHECK CONSTRAINT [FK_FunzioniBanche_Funzionalita]
GO
ALTER TABLE [dbo].[Movimento]  WITH CHECK ADD  CONSTRAINT [FK_Movimento_ContoCorrenti] FOREIGN KEY([ContoCorrente])
REFERENCES [dbo].[ContoCorrenti] ([IdConto])
GO
ALTER TABLE [dbo].[Movimento] CHECK CONSTRAINT [FK_Movimento_ContoCorrenti]
GO
